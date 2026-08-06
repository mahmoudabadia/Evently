import 'package:flutter/material.dart';

import '../../utilis/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final double? redius;
  final Color? sideColor;
  final double? verticalPadding;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.redius,
    this.verticalPadding,
    this.sideColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.transparentColor,
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(redius ?? 16),
          side: BorderSide(
            color: sideColor ?? AppColors.transparentColor,
            width: 2,
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
