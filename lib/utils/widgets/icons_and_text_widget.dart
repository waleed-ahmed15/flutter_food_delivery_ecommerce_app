import 'package:flutter/material.dart';
import 'package:food_delivery/utils/widgets/small_text.dart';

class IconsAndText extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  const IconsAndText(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
        )
      ],
    );
  }
}
