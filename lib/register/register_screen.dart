import 'package:evently_app/firebase_utilis.dart';
import 'package:evently_app/home/widgets/custom_elevated_button.dart';
import 'package:evently_app/utilis/app_assets.dart';
import 'package:evently_app/utilis/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../home/widgets/custom_text_field.dart';
import '../l10n/app_localizations.dart';
import '../model/user_model.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../utilis/app_colors.dart';
import '../utilis/app_routes.dart';
import '../utilis/dialog_utilis.dart';
import '../utilis/size_utilis.dart';
import '../utilis/toast_utilis.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: "mahmoud@gmail.come",
  );
  TextEditingController nameController = TextEditingController(text: "Mahmoud");
  TextEditingController passController = TextEditingController(text: "123456");
  TextEditingController confirmedController = TextEditingController(
    text: "123456",
  );

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
              spacing: height * .03,
              children: [
                SizedBox(width: width * .03),
                Center(
                  child: Image.asset(
                    width: width * .4,

                    themeProvider.isDarkMode()
                        ? AppAssets.eventlySplashDark
                        : AppAssets.eventlySplashLight,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.create,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.name,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  borderColor: Theme.of(context).dividerColor,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.mainDarkColor
                      : AppColors.whiteColor,
                  fill: true,
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,

                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppColors.lightGreyColor,
                  ),
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
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.confirmed,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  borderColor: Theme.of(context).dividerColor,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.mainDarkColor
                      : AppColors.whiteColor,
                  fill: true,
                  controller: confirmedController,
                  keyboardType: TextInputType.phone,
                  obscureText: true,

                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter confirmed password";
                    }
                    if (text != passController.text) {
                      return "Passwords do not match";
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

                CustomElevatedButton(
                  onPressed: register,
                  backgroundColor: Theme.of(context).cardColor,
                  verticalPadding: height * .015,
                  child: Text(
                    AppLocalizations.of(context)!.signup,
                    style: AppStyles.medium20WhiteDarkColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.alreadyHaveAnAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.loginRouteName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
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
                        )!.registerSuccessfully,
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
                        AppLocalizations.of(context)!.signGoogle,
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

  Future<void> register() async {
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtilis.showLoading(context: context, loadingText: "Loading...");
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passController.text,
            );
        MyUser myUser = MyUser(
          uId: credential.user?.uid ?? "",
          email: emailController.text,
          name: nameController.text,
        );
        await FirebaseUtilis.addUserToFireStore(myUser);

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        DialogUtilis.hideLoading(context: context);
        DialogUtilis.showMessage(
          context: context,
          message: "Registration successful",
          title: "Success",
          posActionName: "Ok",
          posAction: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
            ToastUtilis.showToastMessage(
              message: AppLocalizations.of(context)!.registerSuccessfully,
              backgroundColor: Colors.green,
              textColor: AppColors.whiteColor,
            );
          },
        );
        print("id : ${credential.user?.uid ?? ""}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtilis.hideLoading(context: context);
          DialogUtilis.showMessage(
            context: context,
            message: "The password provided is too weak.",
            title: "Error",
            posActionName: "Ok",
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtilis.hideLoading(context: context);
          DialogUtilis.showMessage(
            context: context,
            message: "The account already exists for that email.",
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
