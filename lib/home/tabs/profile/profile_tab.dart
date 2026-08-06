import 'package:evently_app/utilis/app_assets.dart';
import 'package:evently_app/utilis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/language_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utilis/app_routes.dart';
import '../../../utilis/app_theme.dart';
import '../../../utilis/size_utilis.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  double? height;

  double? width;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);


    height = context.height;
    width = context.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width! * .04),
        child: Column(
          spacing: height! * .02,
          children: [
            SizedBox(height: height! * .04),

            CircleAvatar(radius: 50, child: Image.asset(AppAssets.profilePic)),
            Text(userProvider.currentUser!.name,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineLarge,
            ),
            Text(
              userProvider.currentUser!.email,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,
            ),

            _buildItemWidget(
              isDark: themeProvider.isDarkMode(),
              text: AppLocalizations.of(context)!.darkMode,
              item: Switch(
                activeThumbColor: AppColors.mainDarkColor,
                inactiveThumbColor: AppColors.whiteColor,
                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                    Set<WidgetState> states,) {
                  if (states.contains(WidgetState.disabled)) {
                    return AppColors.whiteColor;
                  }
                  return AppColors.transparentColor;
                }),
                value: themeProvider.isDarkMode(),
                onChanged: (value) {
                  themeProvider.changeTheme(
                    value ? AppTheme.darkTheme : AppTheme.lightTheme,
                  );
                },
              ),
            ),
            _buildItemWidget(
              isDark: themeProvider.isDarkMode(),
              text: AppLocalizations.of(context)!.language,
              item: IconButton(
                onPressed: () {
                  languageBottomSheet(context);
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme
                      .of(context)
                      .cardColor,
                ),
              ),
            ),
            _buildItemWidget(
              isDark: themeProvider.isDarkMode(),
              text: AppLocalizations.of(context)!.logOut,
              item: IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.loginRouteName, (route) => false);
                },
                icon: Icon(Icons.login_outlined, color: AppColors.redColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget({
    required bool isDark,
    required String text,
    required Widget item,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.transparentColor : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme
            .of(context)
            .dividerColor, width: 2),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: width! * 0.02,
          vertical: height! * 0.01,
        ),
        title: Text(text, style: Theme
            .of(context)
            .textTheme
            .headlineMedium),
        trailing: item,
      ),
    );
  }


  void languageBottomSheet(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(
        context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  languageProvider.changeLanguage('ar');
                  Navigator.pop(context);
                },
                child: _buildLanguageItem(
                  context,
                  title: 'العربية',
                  isSelected: languageProvider.appLanguage == 'ar',
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  languageProvider.changeLanguage('en');
                  Navigator.pop(context);
                },
                child: _buildLanguageItem(
                  context,
                  title: 'English',
                  isSelected: languageProvider.appLanguage == 'en',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageItem(BuildContext context,
      {required String title, required bool isSelected}) {
    if (isSelected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.mainLightColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme
              .of(context)
              .primaryColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.check, color: Theme
                .of(context)
                .primaryColor),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme
              .of(context)
              .dividerColor, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,
            ),
          ],
        ),
      );
    }
  }
}


