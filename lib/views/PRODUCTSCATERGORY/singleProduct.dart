import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/bottomBar.dart';

class SingleProduct extends StatelessWidget {
  final assetPath, cookiePrice, cookieName;

  SingleProduct({this.assetPath, this.cookieName, this.cookiePrice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(""),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white,),
            onPressed: (){
              print("TEST");
            },
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 15.0,),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Cakes",
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),),
          ),
          SizedBox(height: 15.0,),
          Hero(
            tag: assetPath,
            child: Image.asset(assetPath,
              height: 150.0,
              width: 100.0,
              fit: BoxFit.contain,),
          ),
          SizedBox(height: 20.0,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(cookiePrice,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 25.0,
                    color: Colors.orangeAccent
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(cookieName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 30.0,
                    color: Colors.black
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text("Cold, creamy ice cream sandwich between delicious.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Colors.orangeAccent
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.orangeAccent
              ),
              child: Center(
                child: Text("Add To Cart",
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      // fontWeight: FontWeight.bold,
                      color:Colors.white
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
