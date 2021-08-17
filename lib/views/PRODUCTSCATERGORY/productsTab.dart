import 'package:flutter/material.dart';
import 'singleProduct.dart';

class ProductsTabs extends StatefulWidget {
  @override
  _ProductsTabsState createState() => _ProductsTabsState();
}

class _ProductsTabsState extends State<ProductsTabs> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(right: 15.0),
        width: MediaQuery.of(context).size.width - 30.0,
        height: MediaQuery.of(context).size.height - 50.0,
        child: GridView.count(
          crossAxisCount: 2,
          primary: false,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.8,
          children: [
            _buildCard("Ice Cream Sandwich", "\$3.99", "assets/cookiemint.jpg", false, true, context),
            _buildCard("Icing Cake", "\$2.0", "assets/cookievan.jpg", false, false, context),
            _buildCard("Mint Cookies", "\$1.99", "assets/cookiecream.jpg", false, true, context),
            _buildCard("Chocolate Cookie", "\$2.22", "assets/cookieclassic.jpg", false, false, context),
            _buildCard("Vanila Cookies", "\$3.99", "assets/cookiechoco.jpg", false, false, context),
          ],
        )
    );
  }

  Widget _buildCard(String name, String price, String imgPath, bool added, bool isFavorite, context){

    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).
          push(MaterialPageRoute(builder:
              (context) => SingleProduct(assetPath: imgPath, cookieName: name, cookiePrice: price,)
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0
                )
              ],
              color: Colors.white
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isFavorite ? Icon(Icons.favorite, color: Colors.orange,) :
                    Icon(Icons.favorite_border, color: Colors.orange,)
                  ],
                ),
              ),
              Hero(
                  tag: imgPath,
                  child: Container(
                    height: 75.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imgPath,),
                            fit: BoxFit.contain
                        )
                    ),
                  )
              ),
              SizedBox(height: 7.0,),
              Text(price, style: TextStyle(
                  color: Colors.orangeAccent,
                  fontFamily: 'Varela',
                  fontSize: 14.0
              )),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black12,
                  height: 1.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if(!added) ...[
                      Icon(Icons.shopping_basket,
                        color: Colors.orangeAccent,
                        size: 12.0,),
                      Text('Add to Cart', style: TextStyle(
                          fontFamily: 'Varela',
                          color: Colors.orange,
                          fontSize: 12.0
                      ),)
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
