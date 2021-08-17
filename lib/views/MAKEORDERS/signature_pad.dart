import 'dart:async';

import 'package:MOrder/models/product.dart';
import 'package:MOrder/models/salesOrder.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:MOrder/controllers/cart_controller.dart';
import 'package:MOrder/controllers/shopping_controller.dart';
import 'package:MOrder/views/MAKEORDERS/makeOrders.dart';

class SignaturePad extends StatefulWidget {
  final List<Product> cartItems;
  final int supplierId;
  final double totalPrice;

  SignaturePad(this.cartItems, this.supplierId, this.totalPrice);

  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final StreamController<OrderState> _controller =
      StreamController<OrderState>.broadcast();
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
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return MakeOder(1);
                  }));
                }),
          ),
        ],
        title: GetX<CartController>(
          builder: (controller) {
            return Text("\$ ${controller.totalPrice}");
          },
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Center(
              child: Text(
                "Signature Required",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                //padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
                child: SfSignaturePad(
                  minimumStrokeWidth: 2,
                  maximumStrokeWidth: 5,
                  strokeColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<OrderState>(
                    stream: _controller.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == OrderState.Loading) {
                          return Center(
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator()));
                        }
                      }
                      return ElevatedButton(
                        child: Text('Done'),
                        onPressed: () async {
                          await addOrder();
                        },
                      );
                    }),
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  Future<void> addOrder() async {
    _controller.add(OrderState.Loading);
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkJEU2pBYnRPYWhFMEQtSjFmTXZ6MyJ9.eyJodHRwczovL3d3dy5tc2FsZXMuY29tL2VtYWlsIjoiZHVsYW5qYW5zZWpAZ21haWwuY29tIiwiaHR0cHM6Ly93d3cubXNhbGVzLmNvbS9lbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDYwNzAwYzgyMGE0YjU1MDA2OTJkYjgyOSIsImF1ZCI6WyJodHRwOi8vcHVibGljLmFwaS5tc2FsZXNhcHAuY29tIiwiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTYyODc1NzI4MywiZXhwIjoxNjI4ODQzNjgzLCJhenAiOiJCN0ZObXV2ZVRjZG4zZWthcVQ3eU1PZUs0Szgwd1FpOCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.W1PjgtvHftPk32_gRdWUnMZjucO4mT8sN6y0iQoL8bLpoWJLmMYZ68Kc7nGabmFq1MTuDeTpxhxrZsEJEGj_1P6AhSwPKSgu6TRML7UO5NtnfVAeUzHzkTahE6e8oomw79DVvNmMrN93pVmoPyrXsDAW8Uo0KMR5ca-00r4P3A9XmI2QmsE3vLxdQ1e0zJ-F8KgLlt_SspHsQil-XsjrMPqNgra7XBsthGMS0jwsXa8GJQ7IK1oRqc95-7c9dg6VTZtmvkO3_uFtfRC0m5GXdyO4B1OWVSH7kdnEz4kK2oFAwHIhyhRfILoyZlGfXl8kWgeHgW-jA8kUFYBUWlHuOg',
      'Content-Type': 'application/json',
      'Cookie': 'JSESSIONID=B2E911507B6EE95774EC0246B10F5F5F',
      'BusinessId': 'partner-1'
    };

    var salesOrder = SalesOrder(
      referenceId: "generated33333",
      captureTime: DateTime.now().toUtc().toIso8601String(),
      channel: "MORDER",
      creationLatitiude: 0,
      creationLongitude: 0,
      notes: '',
      customerId: 13,
      orderSubTotal: widget.totalPrice,
      taxSubTotal: widget.totalPrice / 10,
      orderTotal: widget.totalPrice + (widget.totalPrice / 10),
      items: widget.cartItems
          .map<Items>((e) => Items(
              productCode: e.id,
              description: e.productDescription,
              quantity: e.quantity,
              unitPrice: e.price,
              taxRate: 10,
              taxCode: 'GST',
              subTotalPrice: (e.price * e.quantity),
              subTotalTax: (e.price * e.quantity) / 10))
          .toList(),
    );

    var response = await http.post(
        Uri.parse('https://api.msalesapp.com/API/V1/SalesOrders'),
        body: json.encode(
          salesOrder.toJson(),
        ),
        headers: headers);

    print(json.encode(salesOrder.toJson()));
    if (response.statusCode == 200) {
      print(response.body);
      _controller.add(OrderState.Loaded);
      SnackBar snackBar = SnackBar(content: Text('Successfully Ordered'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      cartControllert.clearItemCount();
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
    }
  }
}

enum OrderState { Initial, Loading, Loaded }
