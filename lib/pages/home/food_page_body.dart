import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controllers.dart';
import 'package:food_delivery/controllers/recommended_products_controller.dart';
import 'package:food_delivery/models/popular_products_model.dart';
import 'package:food_delivery/pages/food/food_detail.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/widgets/big_text.dart';
import 'package:food_delivery/utils/widgets/icons_and_text_widget.dart';
import 'package:food_delivery/utils/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:dots_indicator/dots_indicator.dart';

class PageFoodBody extends StatefulWidget {
  PageFoodBody({Key? key}) : super(key: key);

  @override
  State<PageFoodBody> createState() => _PageFoodBodyState();
}

class _PageFoodBodyState extends State<PageFoodBody> {
  PageController controller = PageController(viewportFraction: 0.8);

  var _currentpagevalue = 0.0;
  var scaleFactor = 0.8;
  var height = AppLayout.getHeight(220).toInt();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        _currentpagevalue = controller.page!;
        print("current value is ${_currentpagevalue}");
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // sldier section=====================--------------
        GetBuilder<PopularProductControllers>(
          builder: (popularproduct) {
            return popularproduct.isloaded
                ? Container(
                    // color: Colors.red,
                    height: AppLayout.getHeight(320),
                    child: PageView.builder(
                      controller: controller,
                      itemCount: popularproduct.popularProductList.length,
                      itemBuilder: (context, position) {
                        return pageBuilerItem(position,
                            popularproduct.popularProductList[position]);
                      },
                    ),
                  )
                : Container(
                    height: AppLayout.getHeight(320),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    )));
          },
        ),
        //dot below slider section---------------------------------------
        GetBuilder<PopularProductControllers>(
          builder: (popularproduct) {
            return DotsIndicator(
              dotsCount: popularproduct.popularProductList.isEmpty
                  ? 1
                  : popularproduct.popularProductList.length,
              position: _currentpagevalue,
              decorator: DotsDecorator(
                size: Size(AppLayout.getWidth(9), AppLayout.getHeight(9)),
                activeColor: AppColors.mainColor,
                activeSize:
                    Size(AppLayout.getWidth(18), AppLayout.getHeight(9)),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
        SizedBox(height: AppLayout.getHeight(20)),
        Container(
          margin: EdgeInsets.only(
            left: AppLayout.getWidth(30),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(
                width: AppLayout.getWidth(10),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: AppLayout.getHeight(4),
                ),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: AppLayout.getWidth(10),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: AppLayout.getHeight(4)),
                child: SmallText(text: "food pairing"),
              ),
            ],
          ),
        ),
        GetBuilder<RecommendedProductControllers>(
          builder: (recommendedProduct) {
            return ListView.builder(
              shrinkWrap: true,
              // the physics property  makes the list scroable witohut affecting pages scrollability
              physics: NeverScrollableScrollPhysics(),
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (
                context,
                int index,
              ) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      RoutesHelper.getRecommendedFood(index),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: AppLayout.getWidth(20),
                      right: AppLayout.getWidth(20),
                      bottom: AppLayout.getHeight(20),
                    ),
                    child: Row(
                      children: [
                        //this container  shows images section
                        Container(
                          width: AppLayout.getWidth(120),
                          height: AppLayout.getHeight(120),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(20)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(AppConstants.baseUrl +
                                  AppConstants.uploadUrl +
                                  recommendedProduct
                                      .recommendedProductList[index].img!),
                            ),
                          ),
                        ),

                        //this container shows side section of the image which contains name etc
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                  AppLayout.getHeight(20),
                                ),
                                bottomRight: Radius.circular(
                                  AppLayout.getHeight(20),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: AppLayout.getWidth(10),
                                horizontal: AppLayout.getHeight(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: recommendedProduct
                                      .recommendedProductList[index].name!,
                                ),
                                SizedBox(
                                  height: AppLayout.getHeight(10),
                                ),
                                SmallText(
                                    text: recommendedProduct
                                        .recommendedProductList[index]
                                        .description),
                                SizedBox(
                                  height: AppLayout.getHeight(10),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }

  Widget pageBuilerItem(int pos, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (pos == _currentpagevalue.floor()) {
      var currScale = 1 - (_currentpagevalue - pos) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (pos == _currentpagevalue.floor() + 1) {
      var currScale =
          scaleFactor + (_currentpagevalue - pos + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
      ;
    } else if (pos == _currentpagevalue.floor() - 1) {
      var currScale = 1 - (_currentpagevalue - pos) * (1 - scaleFactor);

      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(0, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor), 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          //slider section//----------------------------------
          GestureDetector(
            onTap: () {
              Get.toNamed(RoutesHelper.getPopularFood(pos));
            },
            child: Container(
              height: AppLayout.getHeight(220),
              margin: EdgeInsets.only(
                left: AppLayout.getWidth(10),
                right: AppLayout.getWidth(10),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppLayout.getWidth(30)),
                color: Colors.amber.shade100,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.baseUrl +
                      AppConstants.uploadUrl +
                      popularProduct.img!),
                ),
              ),
            ),
          ),

          //============sldier smaller white container-----------------------
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: AppLayout.getHeight(154),
              margin: EdgeInsets.only(
                left: AppLayout.getWidth(20),
                right: AppLayout.getWidth(20),
                bottom: AppLayout.getHeight(20),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffe8e8e8),
                    blurRadius: AppLayout.getHeight(5),
                    offset: Offset(0, AppLayout.getHeight(5)),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(AppLayout.getWidth(-5), 0),
                  ),
                  BoxShadow(
                    offset: Offset(AppLayout.getWidth(5), 0),
                    color: Colors.white,
                  )
                ],
                borderRadius: BorderRadius.circular(AppLayout.getWidth(30)),
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: AppLayout.getHeight(10),
                  left: AppLayout.getWidth(15),
                  right: AppLayout.getWidth(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: popularProduct.name!,
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
                                    Icons.star,
                                    color: AppColors.mainColor,
                                  )),
                        ),
                        SmallText(text: popularProduct.stars!.toString()),
                        SizedBox(
                          width: AppLayout.getWidth(10),
                        ),
                        SmallText(text: "1243 "),
                        SizedBox(
                          width: AppLayout.getWidth(10),
                        ),
                        SmallText(text: "comments")
                      ],
                    ),
                    SizedBox(
                      height: AppLayout.getHeight(20),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
