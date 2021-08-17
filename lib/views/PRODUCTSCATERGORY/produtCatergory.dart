import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';
import 'gridCategory.dart';

class mainCategory extends StatefulWidget {
  @override
  _mainCategoryState createState() => _mainCategoryState();
}

class _mainCategoryState extends State<mainCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Categories"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(icon: Icon(Icons.add_shopping_cart_outlined), onPressed: (){print("Cart Cliked");})
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          // SizedBox(height: 110,),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("All Catergories", style: TextStyle(color: Colors.purple, fontSize: 20.0),)
                  ],
                ),
                IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.notifications_active_outlined),
                  onPressed: (){})
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          gridCatergory()
        ],
      ),
    );
  }
}
