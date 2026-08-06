import 'package:evently_app/utilis/app_assets.dart';
import 'package:evently_app/utilis/size_utilis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../utilis/app_colors.dart';
import '../utilis/app_routes.dart';
import '../utilis/app_styles.dart';
import '../utilis/app_theme.dart';

class OnboardingMain extends StatefulWidget {
  const OnboardingMain({super.key});

  @override
  State<OnboardingMain> createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool _ = themeProvider.appTheme == AppTheme.lightTheme;
    bool isEnglish = languageProvider.appLanguage == 'en';
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Image.asset(
                  themeProvider.isDarkMode()
                      ? AppAssets.eventlySplashDark
                      : AppAssets.eventlySplashLight,
                  width: SizeConfig.width(context) * .38,
                ),
                const SizedBox(height: 80),
                Image.asset(
                  themeProvider.isDarkMode()
                      ? AppAssets.onboardingDark
                      : AppAssets.onboardingLight,
                  height: SizeConfig.height(context) * .4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.onboardingHeadline,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.onboardingText,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.language,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
                            decoration: BoxDecoration(
                              color: isEnglish
                                  ? AppColors.mainLightColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: () {
                                languageProvider.changeLanguage('en');
                                    },
                              child: Text(
                                AppLocalizations.of(context)!.english,
                                style: TextStyle(
                                  color: isEnglish
                                      ? Colors.white
                                      : AppColors.mainLightColor,

                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: !isEnglish
                                  ? AppColors.mainLightColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: () {
                                languageProvider.changeLanguage(
                                  'ar',
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.arabic,
                                style: TextStyle(
                                  color: !isEnglish
                                      ? Colors.white
                                      : AppColors.mainLightColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.theme,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Row(

                        children: [
                          Container(
                            width:SizeConfig.width(context)*.15,
                            decoration: BoxDecoration(
                              color: !themeProvider.isDarkMode()
                                  ? AppColors.mainLightColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {
                                themeProvider.changeTheme(AppTheme.lightTheme);
                              },
                              icon: const Icon(Icons.light_mode_outlined),
                              color: !themeProvider.isDarkMode()
                                  ? AppColors.whiteColor
                                  : AppColors.mainLightColor
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width:SizeConfig.width(context)*.15,
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode()
                                  ? AppColors.mainLightColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {
                                themeProvider.changeTheme(AppTheme.darkTheme);
                              },
                              icon: const Icon(Icons.dark_mode_outlined),
                              color: themeProvider.isDarkMode()
                                  ? AppColors.whiteColor
                                  : AppColors.mainLightColor
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height:  20),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.onboardingMovingRouteName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainLightColor,
                    ),
                    width: SizeConfig.width(context) * .9,
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.onboardingStart,
                        style: AppStyles.semi20White,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
