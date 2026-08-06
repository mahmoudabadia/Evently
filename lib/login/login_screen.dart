import 'package:evently_app/home/widgets/custom_elevated_button.dart';
import 'package:evently_app/utilis/app_assets.dart';
import 'package:evently_app/utilis/app_routes.dart';
import 'package:evently_app/utilis/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../firebase_utilis.dart';
import '../home/widgets/custom_text_field.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../utilis/app_colors.dart';
import '../utilis/dialog_utilis.dart';
import '../utilis/size_utilis.dart';
import '../utilis/toast_utilis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: "mahmoud@gmail.come",
  );
  TextEditingController passController = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: height * .04,
              children: [
                SizedBox(height: height * .01, width: width * .03),
                Center(
                  child: Image.asset(
                    width: width * .4,

                    themeProvider.isDarkMode()
                        ? AppAssets.eventlySplashDark
                        : AppAssets.eventlySplashLight,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.loginTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.email,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  borderColor: Theme.of(context).dividerColor,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.mainDarkColor
                      : AppColors.whiteColor,
                  fill: true,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your email";
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(emailController.text);
                    if (!emailValid) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.lightGreyColor,
                  ),
                ),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.pass,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  borderColor: Theme.of(context).dividerColor,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.mainDarkColor
                      : AppColors.whiteColor,
                  fill: true,
                  controller: passController,
                  keyboardType: TextInputType.phone,
                  obscureText: true,

                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your password";
                    }
                    if (text.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.lightGreyColor,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility_off_outlined,
                    color: AppColors.lightGreyColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.forgetPassRouteName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgetPassword,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).cardColor,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomElevatedButton(
                  onPressed: login,
                  backgroundColor: Theme.of(context).cardColor,
                  verticalPadding: height * .015,
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: AppStyles.medium20WhiteDarkColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dontHaveAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.registerRouteName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.signup,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).cardColor,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 2,
                        indent: width * .06,
                        endIndent: width * .06,
                      ),
                    ),
                    Text(AppLocalizations.of(context)!.or),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 2,
                        indent: width * .06,
                        endIndent: width * .06,
                      ),
                    ),
                  ],
                ),
                CustomElevatedButton(
                  onPressed: () async {
                    UserCredential? userCredential = await signInWithGoogle();
                    if (userCredential != null) {
                      ToastUtilis.showToastMessage(
                        message: AppLocalizations.of(
                          context,
                        )!.loginSuccessfully,
                        backgroundColor: Colors.green,
                        textColor: AppColors.whiteColor,
                      );
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.homeRouteName,
                      );
                    }
                  },
                  backgroundColor: themeProvider.isDarkMode()
                      ? AppColors.transparentColor
                      : AppColors.whiteColor,
                  verticalPadding: height * .015,
                  sideColor: Theme.of(context).dividerColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: width * 0.02,
                    children: [
                      Image.asset(AppAssets.googleLogo),
                      Text(
                        AppLocalizations.of(context)!.googleLogin,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;


      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }
  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtilis.showLoading(context: context, loadingText: AppLocalizations.of(context)!.loading);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passController.text,
            );
        var myUser = await FirebaseUtilis.getUserFromFireStore(
          credential.user?.uid ?? "",
        );
        if(myUser == null ){
          return ;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(
          myUser
        );
        DialogUtilis.hideLoading(context: context);
        DialogUtilis.showMessage(
          context: context,
          message:AppLocalizations.of(context)!.loginSuccessfully,
          title: AppLocalizations.of(context)!.success,
          posActionName: AppLocalizations.of(context)!.ok,
          posAction: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
            ToastUtilis.showToastMessage(
              message: AppLocalizations.of(context)!.loginSuccessfully,
              backgroundColor: Colors.green,
              textColor: AppColors.whiteColor,
            );
          },
        );
        print("id : ${credential.user?.uid ?? ""}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtilis.hideLoading(context: context);
          DialogUtilis.showMessage(
            context: context,
            message: "The supplied auth credential is malformed or has expired",
            title: "Error",
            posActionName: "Ok",
          );
        }
      } catch (e) {
        DialogUtilis.hideLoading(context: context);
        DialogUtilis.showMessage(
          context: context,
          message: e.toString(),
          title: "Error",
          posActionName: "Ok",
        );
      }
      // Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    }
  }
}
