import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controllers.dart';
import 'package:food_delivery/models/popular_products_model.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/widgets/app_column.dart';
import 'package:food_delivery/utils/widgets/app_icon.dart';
import 'package:food_delivery/utils/widgets/big_text.dart';
import 'package:food_delivery/utils/widgets/expandable_text.dart';
import 'package:food_delivery/utils/widgets/icons_and_text_widget.dart';
import 'package:food_delivery/utils/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageIndex;
  // final ProductModel product;

  PopularFoodDetail({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        Get.find<PopularProductControllers>().popularProductList[pageIndex];
    Get.find<PopularProductControllers>()
        .initProduct(Get.find<CartController>(), product.id!);
    // Get.find<PopularProductControllers>().getQuantity(product.id!);

    // print(product.name);
    // print('page id is ${pageIndex}');
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.baseUrl +
                      AppConstants.uploadUrl +
                      product.img!),
                ),
              ),
              width: double.infinity,
              height: AppLayout.getHeight(350),
            ),
          ),
          Positioned(
              top: AppLayout.getHeight(45),
              left: AppLayout.getWidth(20),
              right: AppLayout.getWidth(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesHelper.intialRoute);
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios_new_outlined)),
                  GetBuilder<PopularProductControllers>(
                    builder: (controller) {
                      return Badge(
                          badgeColor: AppColors.mainColor,
                          badgeContent: Text(controller.totalItems.toString()),
                          child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RoutesHelper.cartPage);
                              },
                              child:
                                  AppIcon(icon: Icons.shopping_cart_outlined)));
                    },
                  ),
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: AppLayout.getHeight(350) - AppLayout.getHeight(100),
            // alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: AppLayout.getWidth(20),
                  horizontal: AppLayout.getHeight(20)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    AppLayout.getHeight(20),
                  ),
                  topRight: Radius.circular(
                    AppLayout.getHeight(20),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name!,
                  ),
                  BigText(text: "Introduce"),
                  SizedBox(
                    height: AppLayout.getHeight(10),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(text: product.description!),
                    ),
                  )
                ],
              ),
            ),
          ),
          //expandable text part//========================
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            vertical: AppLayout.getHeight(30),
            horizontal: AppLayout.getWidth(20)),
        height: AppLayout.getHeight(120),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              AppLayout.getHeight(40),
            ),
            topRight: Radius.circular(
              AppLayout.getHeight(40),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<PopularProductControllers>(
              builder: (popularcontroller) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: AppLayout.getHeight(20),
                      horizontal: AppLayout.getWidth(20)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        popularcontroller.setQuantity(false);
                        // popularcontroller.removeItem(product.id!);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: AppLayout.getWidth(5),
                    ),
                    BigText(text: popularcontroller.quantity.toString()),
                    SizedBox(
                      width: AppLayout.getWidth(5),
                    ),
                    GestureDetector(
                      onTap: () {
                        popularcontroller.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    )
                  ]),
                );
              },
            ),
            GestureDetector(
              onTap: () {
                Get.find<PopularProductControllers>().addItems(product);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: AppLayout.getHeight(10),
                  horizontal: AppLayout.getWidth(10),
                ),
                child: BigText(
                  text: "\$${product.price} Add to cart",
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
