import 'package:MOrder/models/productCatagories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'productCategory.dart';

class ProductCatTile extends StatelessWidget {

  final Product product;
  const ProductCatTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Image.network(product.imageLink),
                  // child: Image.asset(
                  //   "assets/images/products/cookiechoco.jpg",
                  //   fit: BoxFit.cover,
                  // ),
                )
              ],
            ),
            SizedBox(height: 8,),
            Text(product.name, style: TextStyle(fontSize: 14.0),),
            SizedBox(height: 8,),
            if(product.rating != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.green
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.rating.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 8,),
            Text(
              '\$${product.price}',
              style: TextStyle(
                  fontSize: 32.0
              ),
            )
          ],
        ),
      ),
    );
  }
}
