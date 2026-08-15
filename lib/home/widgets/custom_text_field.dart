import 'package:flutter/material.dart';

import '../../utilis/app_colors.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextField extends StatelessWidget {
  final double? redius;
  final Color? borderColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final bool? fill;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final OnValidator? validator;

  const CustomTextField({
    super.key,
    this.redius,
    this.borderColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.fillColor,
    this.fill,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: builtDecorationItem(
          redius: redius ?? 16,
          borderColor: borderColor ?? AppColors.strokeWhiteColor,
        ),
        focusedBorder: builtDecorationItem(
          redius: redius ?? 16,
          borderColor: AppColors.mainLightColor,
        ),
        errorBorder: builtDecorationItem(
          redius: redius ?? 16,
          borderColor: AppColors.redColor,
        ),
        focusedErrorBorder: builtDecorationItem(
          redius: redius ?? 16,
          borderColor: AppColors.redColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        fillColor: fillColor,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,


    );
  }

  OutlineInputBorder builtDecorationItem({
    required double redius,
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }
}
