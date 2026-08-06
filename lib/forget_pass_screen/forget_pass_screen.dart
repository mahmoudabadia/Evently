import 'package:evently_app/utilis/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../home/widgets/custom_elevated_button.dart';
import '../home/widgets/custom_text_field.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../utilis/app_colors.dart';
import '../utilis/app_styles.dart';
import '../utilis/size_utilis.dart';


class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.forgetPass,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: width * .02,
            top: height * .01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: themeProvider.isDarkMode()
                ? AppColors.darkBgColor
                : AppColors.whiteColor,
            border: Border.all(color: Theme.of(context).dividerColor, width: 2),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * .06),

              Center(
                child: Image.asset(
                  themeProvider.isDarkMode()
                      ? AppAssets.forgetPassDark
                      : AppAssets.forgetPassLight,
                ),
              ),
              SizedBox(height: height * .03),

              CustomTextField(
                controller: _emailController,
                hintText: "Enter your email",
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: height * .03),

              SizedBox(
                width: width * .9,
                child: CustomElevatedButton(
                  onPressed: () {
                    resetPassword(email: _emailController.text);
                  },
                  backgroundColor: Theme.of(context).cardColor,
                  verticalPadding: height * .015,
                  child: Text(
                    AppLocalizations.of(context)!.reset,
                    style: AppStyles.medium20WhiteDarkColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword({required String email}) async {
    if (email.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter your email",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.trim(),
      );

      Fluttertoast.showToast(
        msg: "A password reset link has been sent to your email",
        toastLength: Toast.LENGTH_LONG,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Error , try again later";

      if (e.code == 'user-not-found') {
        errorMessage = "There is no user found with this email";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format";
      }

      Fluttertoast.showToast(msg: errorMessage);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}