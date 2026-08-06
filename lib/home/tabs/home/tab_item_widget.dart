import 'package:evently_app/utilis/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../utilis/size_utilis.dart';

class TabItemWidget extends StatelessWidget {
  final bool isSelected;

  final Color unselectedColor;
  final String eventName;



  const TabItemWidget({
    super.key,
    required this.isSelected,

    required this.unselectedColor,
    required this.eventName,

  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * .04,
        vertical: height * .01,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).cardColor : unselectedColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor, width: 2),
      ),
      child: Text(
        eventName,
        style: isSelected
            ? AppStyles.medium16White
            : Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
