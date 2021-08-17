import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';

class invoiceSetlement extends StatefulWidget {
  @override
  _invoiceSetlementState createState() => _invoiceSetlementState();
}

class _invoiceSetlementState extends State<invoiceSetlement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Setlement"),
        backgroundColor: Colors.orange,
      ),
      drawer: MainDrawer(),
    );
  }
}
