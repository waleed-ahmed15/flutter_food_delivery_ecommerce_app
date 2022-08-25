import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controllers.dart';
import 'package:food_delivery/controllers/recommended_products_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/food_detail.dart';
import 'package:food_delivery/pages/food/recommended_foood_detail.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  //makes sure dependencies are loaded
  WidgetsFlutterBinding.ensureInitialized();
  await dep.innit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.tff
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductControllers>().getPopularProductList();
    Get.find<RecommendedProductControllers>().getRecommendedProductList();
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      getPages: RoutesHelper.routes,
      home: MainFoodPage(),
      // home: CartPage(),
    );
  }
}
