import 'package:evently_app/utilis/app_colors.dart';
import 'package:evently_app/utilis/size_utilis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../utilis/app_assets.dart';
import '../utilis/app_routes.dart';
import 'on_boarding.dart';

class OnboardingModel {
  final String imageLight;
  final String imageDark;
  final String titleKey;
  final String descriptionKey;

  OnboardingModel({
    required this.imageLight,
    required this.imageDark,
    required this.titleKey,
    required this.descriptionKey,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // void _finishOnboarding() {
  //   Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
  // }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode();
    var localizations = AppLocalizations.of(context)!;

    final List<OnboardingModel> pages = [
      OnboardingModel(
        imageLight: AppAssets.onboarding1LightNew,
        imageDark: AppAssets.onboarding1DarkNew,
        titleKey: localizations.onboardingOneHead,
        descriptionKey: localizations.onboardingOneBody,
      ),
      OnboardingModel(
        imageLight: AppAssets.onboarding2Light,
        imageDark: AppAssets.onboarding2DarkNew,
        titleKey: localizations.onboardingTwoHead,
        descriptionKey: localizations.onboardingTwoBody,
      ),
      OnboardingModel(
        imageLight: AppAssets.onboarding3Light,
        imageDark: AppAssets.onboarding3DarkNew,
        titleKey: localizations.onboardingThreeHead,
        descriptionKey: localizations.onboardingThreeBody,
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentIndex > 0)
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: isDarkMode
                            ? AppColors.whiteColor
                            : AppColors.mainLightColor,
                      ),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    )
                  else
                    const SizedBox(width: 48),
                  Image.asset(
                    isDarkMode
                        ? AppAssets.eventlySplashDark
                        : AppAssets.eventlySplashLight,
                    height: SizeConfig.height(context) * .03,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.whiteColor
                            : AppColors.mainLightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = pages[index];
                    return OnboardingItemWidget(
                      imagePath: isDarkMode ? item.imageDark : item.imageLight,
                      title: item.titleKey,
                      description: item.descriptionKey,
                      pageCount: pages.length,
                      currentIndex: _currentIndex,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainLightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_currentIndex == pages.length - 1) {
                     Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    _currentIndex == pages.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
