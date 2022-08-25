import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  double textheight;
  int num_line;
  SmallText({
    Key? key,
    this.textheight = 1.2,
    this.num_line = 1,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 12,
    this.color = const Color(0xFFccc7c5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: num_line,
      style: TextStyle(
        fontFamily: "Roboto",
        color: color,
        fontSize: AppLayout.getHeight(size),
        height: textheight,
        overflow: overflow,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
