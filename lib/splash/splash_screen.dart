import 'package:evently_app/utilis/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../onboarding/onboarding_main.dart';
import '../providers/theme_provider.dart';
import '../utilis/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, AppRoutes.onboardingRouteName);
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 240),
          Center(
            child: Image.asset(
              isDarkMode
                  ? AppAssets.eventlySplashDark
                  : AppAssets.eventlySplashLight,
            ),
          ),
          const SizedBox(height: 120),
          Image.asset(AppAssets.routeLogoSplash),
        ],
      ),
    );
  }
}