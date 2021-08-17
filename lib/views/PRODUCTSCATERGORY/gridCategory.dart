import 'package:flutter/material.dart';
import 'selectedProductRange.dart';

class gridCatergory extends StatelessWidget {

  Item items1 = new Item(
      title: "FAVORITES",
      subtitle: "All thing what you like",
      event: "3 Event",
      Ficon: 'favorite_border'
  );

  Item items2 = new Item(
      title: "PROMOTIONS",
      subtitle: "All thing what you like",
      event: "3 Event",
      Ficon: 'Icons.favorite_border'

  );

  Item items3 = new Item(
      title: "BROWNIES",
      subtitle: "All thing what you like",
      event: "3 Event",
      Ficon: 'Icons.favorite_border'
  );

  Item items4 = new Item(
      title: "CHOCOLATE",
      subtitle: "CHOCKS",
      event: "3 Event",
      Ficon: 'Icons.favorite_border'
  );

  Item items5 = new Item(
      title: "CUP CAKES",
      subtitle: "All thing what you like",
      event: "3 Event",
      Ficon: 'Icons.favorite_border'
  );

  Item items6 = new Item(
      title: "FRUIT CAKES",
      subtitle: "All thing what you like",
      event: "3 Event",
      Ficon: 'Icons.favorite_border'
  );

  Item items7 = new Item(
      title: "MACAROONS",
      subtitle: "All thing what you like",
      event: "3 Event",
      Ficon: 'Icons.favorite_border'
  );

  Item items8 = new Item(
      title: "MUFFINS",
      subtitle: "All thing what you like",
      event: "3 Event",
      Ficon: 'icon: Icon(Icons.favorite_border)'
  );

  @override
  Widget build(BuildContext context) {
    List<Item> myProducts = [items1, items2, items3, items4, items5, items6, items7, items8];
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myProducts.map((data){
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset('assets/images/logo/plogo.png'),
                IconButton(
                    iconSize: 40.0,
                    icon: Icon(Icons.favorite),
                    // icon: Icon(Icons.favorite_border),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_){
                            return SelectedProductRange();
                          }
                      ));
                    }),
                SizedBox(height: 14,),
                Text(data.title,
                  style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
                ),
                SizedBox(height: 10,),
                Text(data.subtitle, style: TextStyle(color: Colors.orange),),
                SizedBox(height: 10,),
                Text(data.event, style: TextStyle(color: Colors.red),)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}


class Item{
  String title;
  String subtitle;
  String event;
  String img;
  String Ficon;
  Item({this.title, this.subtitle, this.event, this.img, this.Ficon});
}