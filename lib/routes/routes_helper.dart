import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/food_detail.dart';
import 'package:food_delivery/pages/food/recommended_foood_detail.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RoutesHelper {
  static const String intialRoute = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart';
  static String getInitalRoute() => "$intialRoute";

  static String getPopularFood(int pageIndex) =>
      '$popularFood?pageIndex=$pageIndex';
  static String getRecommendedFood(int pageIndex) =>
      "$recommendedFood?pageIndex=$pageIndex";

  static List<GetPage> routes = [
    GetPage(
      name: '/',
      page: () => MainFoodPage(),
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageIndex = Get.parameters['pageIndex'];
        print(Get.parameters);

        print('popular food details page called');
        return PopularFoodDetail(pageIndex: int.parse(pageIndex!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageIndex = Get.parameters['pageIndex'];
        return RecomendedFoodDetail(
          pageIndex: int.parse(pageIndex!),
        );
      },
      transition: Transition.fade,
    ),
    GetPage(name: cartPage, page:() => CartPage())
  ];
}
