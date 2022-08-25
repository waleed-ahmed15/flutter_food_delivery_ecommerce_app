import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controllers.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/widgets/app_icon.dart';
import 'package:food_delivery/utils/widgets/big_text.dart';
import 'package:food_delivery/utils/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductControllers>()
        .initProduct(Get.find<CartController>(), 2);
    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: AppLayout.getWidth(20),
          top: AppLayout.getHeight(60),
          right: AppLayout.getWidth(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: AppIcon(
                  icon: Icons.arrow_back_ios_new_outlined,
                  iconColor: Colors.white,
                  backgrpoundColor: AppColors.mainColor,
                ),
              ),
              SizedBox(
                width: AppLayout.getWidth(100),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RoutesHelper.intialRoute);
                },
                child: AppIcon(
                  icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgrpoundColor: AppColors.mainColor,
                ),
              ),
              GetBuilder<CartController>(
                builder: (controller) {
                  return Badge(
                    badgeColor: Colors.white,
                    badgeContent: Text(controller.totalItemsCount.toString()),
                    child: AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.white,
                      backgrpoundColor: AppColors.mainColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: AppLayout.getHeight(100),
          right: AppLayout.getWidth(20),
          left: AppLayout.getWidth(20),
          bottom: 0,
          child: Container(
              // color: Colors.red,
              child: GetBuilder<CartController>(
            builder: (controller) {
              return ListView.builder(
                padding: EdgeInsets.only(top: AppLayout.getHeight(10)),
                itemCount: controller.getItems.length,
                // itemCount: Get.find<PopularProductControllers>().getItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.maxFinite,
                    height: AppLayout.getHeight(100),
                    padding: EdgeInsets.only(bottom: AppLayout.getHeight(10)),
                    child: Row(children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeight(20)),
                        child: Image(
                          errorBuilder: (context, error, stackTrace) {
                            return CircularProgressIndicator();
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstants.baseUrl +
                              AppConstants.uploadUrl +
                              controller.getItems[index].img!),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: AppLayout.getWidth(10),
                              top: AppLayout.getHeight(10),
                              bottom: AppLayout.getHeight(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: controller.getItems[index].name!,
                                size: AppLayout.getHeight(20),
                                color: Colors.black54,
                              ),
                              SmallText(text: controller.getItems[index].name!),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BigText(
                                    text:
                                        '\$ ${controller.getItems[index].price}.0',
                                    color: Colors.redAccent,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // popularcontroller.setQuantity(false);
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
                                      BigText(
                                          text: controller
                                              .getItems[index].quantity
                                              .toString()),
                                      // BigText(text: popularcontroller.quantity.toString()),
                                      SizedBox(
                                        width: AppLayout.getWidth(5),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // popularcontroller.setQuantity(true);
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.signColor,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  );
                },
              );
            },
          )),
        ),
      ]),
    );
  }
}
