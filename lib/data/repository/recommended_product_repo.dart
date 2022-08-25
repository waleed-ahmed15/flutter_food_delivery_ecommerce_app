import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  //getx service is needed when ever loading data from the internet

  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductsList() async {
    // this method is to get response from server
    return await apiClient.getData(AppConstants.recommendedProductUri);
  }
}
