import 'package:evently_app/utilis/app_colors.dart';
import 'package:flutter/material.dart';

class OnboardingItemWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final int pageCount;
  final int currentIndex;

  const OnboardingItemWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.pageCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pageCount,
                (dotIndex) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 8,
              width: currentIndex == dotIndex ? 24 : 8,
              decoration: BoxDecoration(
                color: currentIndex == dotIndex
                    ? AppColors.mainLightColor
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}