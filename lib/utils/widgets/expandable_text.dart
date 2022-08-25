import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firsthalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = AppLayout.getHeight(100);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firsthalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(
        textHeight.toInt() + 1,
        widget.text.length,
      );
    } else {
      firsthalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              color: AppColors.paraColor,
              text: firsthalf,
              size: AppLayout.getHeight(16),
            )
          : Column(
              children: [
                SmallText(
                  num_line: hiddenText ? 1 : 300,
                  color: AppColors.paraColor,
                  size: AppLayout.getHeight(16),
                  text:
                      hiddenText ? firsthalf + "...." : firsthalf + secondHalf,
                ),
                InkWell(
                  onTap: (() {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  }),
                  child: Row(
                    children: [
                      SmallText(
                        size: AppLayout.getHeight(16),
                        text: hiddenText ? 'show more ' : 'show less ',
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
