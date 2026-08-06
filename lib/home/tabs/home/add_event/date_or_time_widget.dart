import 'package:flutter/material.dart';

import '../../../../utilis/size_utilis.dart';

class DateOrTimeWidget extends StatelessWidget {
  final Widget icon;

  final String eventDateOrTime;
  final String chooseDateOrTime;
  final VoidCallback onChooseClic;

  const DateOrTimeWidget({
    super.key,
    required this.eventDateOrTime,
    required this.icon,
    required this.chooseDateOrTime,
    required this.onChooseClic,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    return Row(
      children: [
        icon,
        SizedBox(width: width * .02),
        Text(
          eventDateOrTime,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Spacer(),
        SizedBox(width: width * .02),
        TextButton(
          onPressed: onChooseClic,
          child: Text(
            chooseDateOrTime,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).cardColor,
            ),
          ),
        ),
      ],
    );
  }
}
