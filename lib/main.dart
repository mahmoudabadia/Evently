import 'package:evently_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home/edit_screens/details_screen.dart';
import 'home/edit_screens/edit_screen.dart';
import 'l10n/app_localizations.dart';
import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utilis/app_routes.dart';
import 'forget_pass_screen/forget_pass_screen.dart';
import 'home/home_screen.dart';
import 'home/tabs/home/add_event/add_event_screen.dart';
import 'login/login_screen.dart';
import 'onboarding/onboarding_main.dart';
import 'onboarding/onboarding_moving.dart';
import 'register/register_screen.dart';
import 'splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRouteName,
      routes: {
        AppRoutes.splashRouteName: (context) => const SplashScreen(),
        AppRoutes.onboardingRouteName: (context) => const OnboardingMain(),
        AppRoutes.onboardingMovingRouteName: (context) =>
        const OnboardingScreen(),
        AppRoutes.homeRouteName: (context) => const HomeScreen(),
        AppRoutes.loginRouteName: (context) => const LoginScreen(),
        AppRoutes.registerRouteName: (context) => const RegisterScreen(),
        AppRoutes.addEventRouteName: (context) => const AddEventScreen(),
        AppRoutes.forgetPassRouteName: (context) => const ForgetPassScreen(),
        AppRoutes.editEventRouteName: (context) => const EditEventScreen(),
        AppRoutes.eventDetailsRouteName: (context) => const DetailsEventScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      theme: themeProvider.appTheme,
    );
  }
}