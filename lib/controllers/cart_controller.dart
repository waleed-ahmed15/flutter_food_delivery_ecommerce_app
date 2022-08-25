import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/popular_products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  addItem(ProductModel product, int quantity) {
    // addding the new item to the list
    if (!_items.keys.contains(product.id)) {
      _items.putIfAbsent(
        product.id!,
        () {
          // print('adding item to the cart');
          // print(product.name);
          // _items.forEach((key, value) {
          // print(value.name);
          // print(value.quantity);
          // });

          // print('added item');
          Get.snackbar('Successful', 'item added to Cart');
          return CartModel(
            id: product.id,
            img: product.img,
            isExist: true,
            name: product.name,
            price: product.price,
            quantity: quantity,
            time: DateTime.now().toString(),
          );
        },
      );
    }

    //updating the items quantity count
    else if (_items.keys.contains(product.id)) {
      // print('updated item');
      _items[product.id]?.quantity = quantity;
      // print(quantity.toString());

      if (_items[product.id]!.quantity! == 0) {
        Get.snackbar('item removed from cart', '${_items[product.id]!.name}');
        print('deleting item');
        _items.remove(product.id);
        return;
      }
      Get.snackbar('Successful', 'updated  item count in Cart');
    }
  }

  int getQuantity(int productId) {
    if (_items.keys.contains(productId)) {
      return _items[productId]!.quantity!;
    } else {
      return 0;
    }
  }

  void removeItem(int productID) {
    if (_items.keys.contains(productID) && _items[productID]!.quantity! > 0) {
      _items[productID]!.quantity = _items[productID]!.quantity! - 1;
      print('removing item');
      if (_items[productID]!.quantity! == 0) {
        Get.snackbar('item removed from cart', '${_items[productID]!.name}');
        print('deleting item');
        _items.remove(productID);
      }
    }

    // _items.forEach((key, value) {
    //   print(
    //       "the key is $key and name is ${value.name} and Quantity is  ${value.quantity}");
    // });
  }

  int get totalItemsCount {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity = totalQuantity + value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
}
