import 'package:flutter/material.dart';

class TodaysOrders extends StatefulWidget {
  @override
  _TodaysOrdersState createState() => _TodaysOrdersState();
}

class _TodaysOrdersState extends State<TodaysOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Center(
                  child: Text("HOT CHOCOLATE CAKE",
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Varela',
                        fontSize: 60.0
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Center(
                  child: Text("5 Items",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Varela',
                        fontSize: 35.0
                    ),
                  ),
                ),
                SizedBox(height: 14.0,),
                Center(
                  child: Text("\$3.99",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Varela',
                        fontSize: 45.0
                    ),
                  ),
                ),
                SizedBox(height: 14.0,),
                Center(
                  child: Text("Total : \$19.95",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Varela',
                        fontSize: 45.0
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image(
                  image: AssetImage('assets/cookiemint.jpg')
              ),
            ),
          )
        ],
      ),
    );
  }
}
