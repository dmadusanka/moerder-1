import 'package:MOrder/models/product.dart';
import 'package:get/state_manager.dart';

class CartController extends GetxController {
  List<Product> cartItems = <Product>[].obs;
  int get itemCount => cartItems.length;
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  removeProduct(Product product){
    cartItems.remove(product);
  }

  clearItemCount(){
    cartItems.clear();
  }

  addToCart(Product product) {
    if (!cartItems.any((element) => element.id == product.id)) {
      cartItems.add(product);
      return;
    }
    var cartItem = cartItems.firstWhere((element) => element.id == product.id);
    if (cartItem != null) {
      if (cartItem.quantity != product.quantity) {
        cartItem.quantity = product.quantity;
      }
    }
  }
}
