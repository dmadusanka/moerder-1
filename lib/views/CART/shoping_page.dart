import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:MOrder/controllers/cart_controller.dart';
import 'package:MOrder/controllers/shopping_controller.dart';
import 'package:MOrder/views/MAKEORDERS/makeOrders.dart';
import 'package:MOrder/models/product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:MOrder/controllers/api.dart';

class ShoppingPage extends StatelessWidget {
  final String categoryId;

  ShoppingPage(this.categoryId);

  final shoppingController = Get.put(ShoppingController());
  final cartControllert = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Badge(
              position: BadgePosition.topEnd(top: 0, end: 3),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent:GetX<CartController>(
                builder: (controller) {
                  return Text('${controller.itemCount}',
                    style: TextStyle(fontSize: 15, color: Colors.white),);
                },
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return MakeOder(1);
                  }));
                }
              ),
            )
          ],
          title: GetX<CartController>(
            builder: (controller) {
              return Text("\$ ${controller.totalPrice}");
            },
          ),
          backgroundColor: Colors.orange,
        ),
        body: FutureBuilder<List<Product>>(
          future: getProduct(categoryId),
          builder: (context, data) {
            if (data.hasData) {
              if (data.data.length == 0) {
                return Center(
                  child: Text('No Products for this Category'),
                );
              }
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, index) {
                      var imageIMAGE = data.data[index].productImage;
                      var baseURL ='https://demo.msalesapp.com/msales/resources/getBlob/';
                      var imageURL = baseURL + imageIMAGE;
                      return Card(
                        margin: EdgeInsets.all(12),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          //padding: EdgeInsets.all(10.0),
                                          //color: Colors.orangeAccent,
                                          child: Text(
                                            '${data.data[index].productName}',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.orangeAccent),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                            '${data.data[index].productDescription}'),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          '\$ ${data.data[index].price}',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        ChangeNumber((quantity) {
                                          data.data[index].quantity = quantity;
                                        }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Image.network(
                                      imageURL,
                                      height: 100,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cartControllert.addToCart(data.data[index]);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orangeAccent, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                child: Text("Add To Cart"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
                  // Text("Total Amount \$"),
                  // SizedBox(height: 50.0,)
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  void getQuantity(int quantity) {}
}

class ChangeNumber extends StatefulWidget {
  final Function newCount;
  ChangeNumber(this.newCount);

  @override
  State<StatefulWidget> createState() {
    return _ChangeNumber();
  }
}

class _ChangeNumber extends State<ChangeNumber> {
  int _counter = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            if (_counter > 1) {
              setState(() {
                _counter--;
              });
              widget.newCount(_counter);
            }
          },
          icon: Icon(Icons.remove),
        ),
        Text(_counter.toString()),
        IconButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
            widget.newCount(_counter);
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
