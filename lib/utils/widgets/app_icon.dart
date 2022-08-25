import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgrpoundColor;
  final double size;
  final Color iconColor;
  AppIcon({
    Key? key,
    this.size = 40,
    required this.icon,
    this.backgrpoundColor = const Color(0xfffcf4e4),
    this.iconColor = const Color(0xff756d54),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((size / 2)),
          color: backgrpoundColor),
      width: AppLayout.getWidth(size),
      height: AppLayout.getHeight(size),
      child: Icon(
        icon,
        color: iconColor,
        size: AppLayout.getHeight(16),
      ),
    );
  }
}
