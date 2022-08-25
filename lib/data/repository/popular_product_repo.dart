import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  //getx service is needed when ever loading data from the internet

  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductsList() async {
    // this method is to get response from server
    return await apiClient.getData(AppConstants.popularProductsUri);
  }
}
