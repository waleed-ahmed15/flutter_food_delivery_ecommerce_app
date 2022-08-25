import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/recommended_products_controller.dart';
import 'package:food_delivery/models/popular_products_model.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/widgets/app_icon.dart';
import 'package:food_delivery/utils/widgets/big_text.dart';
import 'package:food_delivery/utils/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class RecomendedFoodDetail extends StatelessWidget {
  final int pageIndex;
  RecomendedFoodDetail({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.find<RecommendedProductControllers>()
        .recommendedProductList[pageIndex];
    Get.find<RecommendedProductControllers>()
        .initProduct(Get.find<CartController>(), product.id!);
    // print(product.name);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: AppLayout.getHeight(80),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.getInitalRoute());
                  },
                  child: AppIcon(
                    icon: Icons.clear,
                  ),
                ),
                GetBuilder<RecommendedProductControllers>(
                  builder: (controller) {
                    return Badge(
                      badgeColor: AppColors.mainColor,
                      badgeContent: Text(
                        controller.totalItems.toString(),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesHelper.cartPage);
                        },
                        child: AppIcon(
                          icon: Icons.shopping_cart_outlined,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(AppLayout.getHeight(20)),
              child: Container(
                  padding: EdgeInsets.only(
                      top: AppLayout.getHeight(10),
                      bottom: AppLayout.getHeight(10)),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Center(
                    child: BigText(
                        size: AppLayout.getHeight(26), text: product.name!),
                  )),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: AppLayout.getHeight(300),
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                width: double.maxFinite,
                fit: BoxFit.cover,
                image: NetworkImage(
                  AppConstants.baseUrl + AppConstants.uploadUrl + product.img!,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
              child: ExpandableText(text: product.description!),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<RecommendedProductControllers>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      iconColor: Colors.white,
                      backgrpoundColor: AppColors.mainColor,
                      size: AppLayout.getHeight(30),
                    ),
                  ),
                  BigText(
                    text:
                        "\$${product.price} X ${controller.quantity.toString()}",
                    size: AppLayout.getHeight(26),
                    color: AppColors.mainBlackColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      icon: Icons.add,
                      iconColor: Colors.white,
                      backgrpoundColor: AppColors.mainColor,
                      size: AppLayout.getHeight(30),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppLayout.getHeight(20),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
                height: AppLayout.getHeight(120),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      AppLayout.getHeight(40),
                    ),
                    topRight: Radius.circular(AppLayout.getHeight(40)),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //heart container
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: AppLayout.getHeight(20),
                            horizontal: AppLayout.getWidth(20)),
                        child: Icon(
                          Icons.favorite_sharp,
                          color: AppColors.mainColor,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppLayout.getHeight(20))),
                      ),

                      //add to cart container
                      GestureDetector(
                        onTap: () {
                          controller.addItems(product);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: AppLayout.getHeight(20),
                              horizontal: AppLayout.getWidth(20)),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: BigText(
                            text: "\$ ${product.price} | Add to cart",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ]),
              )
            ],
          );
        },
      ),
    );
  }
}
