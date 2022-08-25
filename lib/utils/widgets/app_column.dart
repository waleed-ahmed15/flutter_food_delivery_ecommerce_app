import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/widgets/big_text.dart';
import 'package:food_delivery/utils/widgets/icons_and_text_widget.dart';
import 'package:food_delivery/utils/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: AppLayout.getHeight(26),
        ),
        SizedBox(
          height: AppLayout.getHeight(10),
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star_sharp,
                  color: AppColors.mainColor,
                  size: 16,
                ),
              ),
            ),
            SizedBox(
              width: AppLayout.getWidth(10),
            ),
            SmallText(text: '4.5'),
            SizedBox(
              width: AppLayout.getWidth(10),
            ),
            SmallText(text: '1264   Comments')
          ],
        ),
        SizedBox(
          height: AppLayout.getHeight(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconsAndText(
                icon: Icons.circle_sharp,
                iconColor: AppColors.iconColor1,
                text: "Normal"),
            IconsAndText(
                icon: Icons.location_on_sharp,
                iconColor: AppColors.mainColor,
                text: "1.7km"),
            IconsAndText(
                icon: Icons.access_time_filled_outlined,
                iconColor: AppColors.iconColor2,
                text: "32min")
          ],
        ),
      ],
    );
  }
}
