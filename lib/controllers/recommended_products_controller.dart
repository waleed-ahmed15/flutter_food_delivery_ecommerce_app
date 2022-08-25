import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/popular_products_model.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class RecommendedProductControllers extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductControllers({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isloaded = false;
  bool get isloaded => _isloaded;

  late CartController cart;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  int _quantity = 0;
  int get quantity => _quantity;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductsList();
    if (response.statusCode == 200) {
      _isloaded = true;
      print("got recomended products");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      for (var element in _recommendedProductList) {
        print(element);
      }

      update(); // it is more like setstate for getx
    } else {
      print("got products falied");
    }
  }

  void setQuantity(bool increment) {
    if (increment) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
    print('updated called');
  }

  // void addToCart() {
  //   _inCartItems += quantity;
  //   update();
  // }

  void addItems(ProductModel product) {
    if (cart.getQuantity(product.id!) + _quantity > 0) {
      cart.addItem(product, _quantity);
      cart.items.forEach((key, value) {
        _quantity = cart.getQuantity(product.id!);
        print(
            "the key is $key and name is ${value.name} and Quantity is  ${value.quantity}");
      });

      update();
    } else {
      Get.snackbar(
        'item count',
        'Add atleast on item in the cart!',
        backgroundColor: AppColors.mainColor,
      );
    }
  }

  void removeItem(int productid) {
    cart.removeItem(productid);
  }

  void initProduct(CartController cartc, int productid) {
    _quantity = 0;
    _inCartItems = 0;
    cart = cartc;
    getQuantity(productid);
  }

  int checkQuantity(int quantity) {
    if (quantity > 20) {
      Get.snackbar(
        'item count',
        'max order limit reached',
        backgroundColor: AppColors.mainColor,
      );
      return 20;
    } else if (quantity < 0) {
      Get.snackbar(
        'item count',
        'cannot go below zero',
        backgroundColor: AppColors.mainColor,
      );

      return 0;
    } else {
      return quantity;
    }
  }

  // method to get the list of popular prodcuts //============================

  void getQuantity(int productID) {
    _quantity = cart.getQuantity(productID);
  }

  int get totalItems {
    return cart.totalItemsCount;
  }
}
