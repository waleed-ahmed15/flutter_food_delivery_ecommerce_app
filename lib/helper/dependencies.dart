import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controllers.dart';
import 'package:food_delivery/controllers/recommended_products_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> innit() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));

  //repos
  Get.lazyPut(
    () => PopularProductRepo(
      apiClient: Get.find(),
    ),
  );
  Get.lazyPut(() => PopularProductControllers(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => RecommendedProductControllers(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartRepo());
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
