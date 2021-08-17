import 'package:MOrder/models/salesOrder.dart';
import 'package:MOrder/models/sales_order_summary.dart';
import 'package:MOrder/views/MAKEORDERS/makeOrders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:MOrder/controllers/shopping_controller.dart';
import 'package:MOrder/controllers/cart_controller.dart';

class OrderHistoryItems extends StatefulWidget {
  final List<OrderItems> salesOrderItems;

  OrderHistoryItems(this.salesOrderItems);
  final double totalAmount = 0.0;

  @override
  _OrderHistoryItemsState createState() => _OrderHistoryItemsState();
}

class _OrderHistoryItemsState extends State<OrderHistoryItems> {
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
      ),
      //drawer: MainDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: [
                        ListTile(
                          //title: Text(controller.cartItems[index].productName, style: TextStyle(fontSize: 20.0),),
                          title: Text(
                              "${widget.salesOrderItems[index].productCode}"),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Order QTY: ${widget.salesOrderItems[index].quantity}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black54),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Unit Price: ${widget.salesOrderItems[index].unitPrice}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black54),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Total: ${widget.salesOrderItems[index].subTotalPrice}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: widget.salesOrderItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
