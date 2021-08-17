import 'package:MOrder/controllers/cart_controller.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:MOrder/controllers/shopping_controller.dart';
import 'package:MOrder/views/CART/productRanges.dart';
import 'package:MOrder/views/MAKEORDERS/signature_pad.dart';

class MakeOder extends StatefulWidget {
  final int supplierId;

  MakeOder(this.supplierId);

  @override
  _MakeOderState createState() => _MakeOderState();
}

class _MakeOderState extends State<MakeOder> {
  final shoppingController = Get.put(ShoppingController());
  final cartControllert = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return AllProductRanges(1);
            }));
          },
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          actions: <Widget>[
            Badge(
              position: BadgePosition.topEnd(top: 0, end: 3),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent: GetX<CartController>(
                builder: (controller) {
                  return Text(
                    '${controller.itemCount}',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  );
                },
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return MakeOder(0);
                    }));
                  }),
            )
          ],
          title: GetX<CartController>(
            builder: (controller) {
              return Text("Total: \$ ${controller.totalPrice}");
            },
          ),
          backgroundColor: Colors.orange,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "ORDER SUMMERY",
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: TabBarView(
          children: [
            GetX<CartController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var unitPrice = controller.cartItems[index].price;
                          var quantity = controller.cartItems[index].quantity;
                          var total = unitPrice * quantity;
                          return Container(
                            child: Card(
                              color: Colors.white,
                              elevation: 2.0,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      controller.cartItems[index].productName,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Unit Price : ${controller.cartItems[index].price.toString()}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.blue),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Quantity : ${controller.cartItems[index].quantity.toString()}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.purple),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Totoal : ${total.toString()}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.brown.withOpacity(0.2)),
                                          ),
                                          child: Text('EDIT', style: TextStyle(color: Colors.white),),
                                          onPressed: () {
                                            cartControllert.removeProduct(
                                                controller.cartItems[index]);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: controller.cartItems.length,
                      ),
                    ),
                    GetX<CartController>(builder: (controller) {
                      if (controller.itemCount == 0) {
                        return Center(
                          child: Text(""),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignaturePad(
                                        controller.cartItems,
                                        widget.supplierId,
                                        controller.totalPrice),
                                  ),
                                );
                              },
                              child: Text('Confirm Order')),
                        );
                      }
                    })
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
