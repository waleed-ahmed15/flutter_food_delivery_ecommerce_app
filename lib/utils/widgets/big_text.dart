import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({
    Key? key,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 0,
    this.color = const Color(0xFF332d2b),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "Roboto",
        color: color,
        fontSize:
            size == 0 ? AppLayout.getHeight(20) : AppLayout.getHeight(size),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
