import 'package:MOrder/models/sales_order_summary.dart';
import 'package:MOrder/views/MAKEORDERS/orderHistoryItrms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:MOrder/controllers/shopping_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:MOrder/controllers/cart_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MATERIAL/mainDrawer.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
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
              // onPressed: () {
              //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              //     return MakeOder();
              //   }));
              // }
            ),
          )
        ],
        title: GetX<CartController>(
          builder: (controller) {
            return Text("Total: \$ ${controller.totalPrice}");
          },
        ),
        backgroundColor: Colors.orange,
      ),
      drawer: MainDrawer(),
      body: FutureBuilder<List<SalesOrderSummary>>(
        future: getSalesSummary(),
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            print(snapshot.data.length);

            var data = snapshot.data;
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return OrderHistoryItems(
                                  data[index].orderItems);
                            }));
                          },
                          child: Container(
                            child: Card(
                              color: Colors.white,
                              elevation: 2.0,
                              child: Column(
                                children: [
                                  ListTile(
                                    //title: Text(controller.cartItems[index].productName, style: TextStyle(fontSize: 20.0),),
                                    title: Container(
                                      child: Column(
                                        children: [
                                          Text("Order ID : ${data[index].internalId}"),
                                          Text("Date Time : ${data[index].creationTime}"),
                                        ],
                                      ),
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Order Total : ${data[index].orderTotal}",
                                          style: TextStyle(
                                              fontSize: 16.0, color: Colors.blue),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Note : ${data[index].notes}",
                                          style: TextStyle(
                                              fontSize: 16.0, color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      // Expanded(
                                      //   child: ElevatedButton(
                                      //     style: ButtonStyle(
                                      //       backgroundColor:
                                      //           MaterialStateProperty.all(
                                      //               Colors.green),
                                      //     ),
                                      //     child: Text('Show Items'),
                                      //     onPressed: () {
                                      //       Navigator.of(context).push(
                                      //           MaterialPageRoute(builder: (_) {
                                      //         return OrderHistoryItems(
                                      //             data[index].orderItems);
                                      //       }));
                                      //       //cartControllert.removeProduct(controller.cartItems[index]);
                                      //     },
                                      //   ),
                                      // ),
                                      // SizedBox(width: 10.0,),
                                      // Expanded(
                                      //   child: ElevatedButton(
                                      //     style: ButtonStyle(
                                      //       backgroundColor:
                                      //       MaterialStateProperty.all(
                                      //           Colors.lightBlueAccent),
                                      //     ),
                                      //     child: Text('Save Order'),
                                      //     onPressed: () {
                                      //       // Navigator.of(context).push(
                                      //       //     MaterialPageRoute(builder: (_) {
                                      //       //       return OrderHistoryItems(
                                      //       //           data[index].orderItems);
                                      //       //     }));
                                      //       //cartControllert.removeProduct(controller.cartItems[index]);
                                      //     },
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List<SalesOrderSummary>> getSalesSummary() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var accessToken = localStorage.getString('ACCESS_TOKEN');
    List<SalesOrderSummary> salesOrderSummary = [];

    var headers = {
      'Authorization':
          'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Cookie': 'JSESSIONID=B2E911507B6EE95774EC0246B10F5F5F',
      'BusinessId': 'partner-1'
    };

    var response = await http.get(
        Uri.parse('https://api.msalesapp.com/API/V1/SalesOrders'),
        headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var salesOrders = json.decode(response.body)["salesOrders"];
      print(salesOrders);

      for (int i = 0; i < salesOrders.length; i++) {
        salesOrderSummary.add(SalesOrderSummary.fromJson(salesOrders[i]));
      }
    } else {
      print(response.reasonPhrase);
    }
    // print(salesOrderSummary.length);
    return salesOrderSummary;
  }
}
