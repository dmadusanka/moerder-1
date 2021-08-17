import 'package:MOrder/models/product.dart';
import 'package:get/state_manager.dart';

class ShoppingController extends GetxController {
  var products = List<Product>().obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchingProduct();
  // }

  // void fetchingProduct() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   var productRespons = [
  //     Product(
  //         1, "chocolate biscuit", 30.0, "Some description goes here", "asd"),
  //     Product(2, "Cremy biscuit", 19.0, "Some description goes here", "asd"),
  //     Product(3, "Vanila biscuit", 45.8, "Some description goes here", "asd"),
  //     Product(3, "Caramel biscuit", 70.2, "Some description goes here", "asd"),
  //     Product(3, "Butter Scotch biscuit", 59.8, "Some description goes here",
  //         "asd"),
  //     Product(
  //         3, "Suger Free biscuit", 13.4, "Some description goes here", "asd"),
  //     Product(3, "biscuit", 16.2, "Some description goes here", "asd"),
  //     Product(3, "Eighth Pro", 11.0, "Some description goes here", "asd"),
  //     Product(3, "Ninth Pro", 84.4, "Some description goes here", "asd"),
  //   ];

  //   products.value = productRespons;
  // }
}
