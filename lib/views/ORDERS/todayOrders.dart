import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';
import 'package:MOrder/views/ORDERS/dataset.dart';

class todaysOrders extends StatefulWidget {
  @override
  _todaysOrdersState createState() => _todaysOrdersState();
}

class _todaysOrdersState extends State<todaysOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Today's Orders"),
      ),
      drawer: MainDrawer(),
      // body: ListView(
      //   scrollDirection: Axis.vertical,
      //   children: [
      //     Padding(padding: EdgeInsets.all(16.0),
      //       child: Container(
      //         child: FittedBox(
      //           child: Material(
      //               color: Colors.white,
      //               elevation: 14.0,
      //               borderRadius: BorderRadius.circular(24.0),
      //               shadowColor: Colors.black12,
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   //TodaysOrders(),
      //                 ],
      //               )
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
