import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';
import 'package:MOrder/views/MATERIAL/bottomBar.dart';
import 'gridProduct.dart';

class SelectedProductRange extends StatefulWidget {
  @override
  _SelectedProductRangeState createState() => _SelectedProductRangeState();
}

class _SelectedProductRangeState extends State<SelectedProductRange>{
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
      drawer: MainDrawer(),
      body: GridProducts(),
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
