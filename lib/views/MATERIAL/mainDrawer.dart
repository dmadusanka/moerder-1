import 'package:MOrder/views/CART/shoping_page.dart';
import 'package:MOrder/views/AUTH/login.dart';
import 'package:MOrder/views/MAKEORDERS/orderHistory.dart';
import 'package:MOrder/views/PRODUCTCATALOGUE/productCatalogueRange.dart';
import 'package:flutter/material.dart';
import 'package:MOrder/views/ORDERS/todayOrders.dart';
import 'package:MOrder/views/OUTSTANDING/outsStanding.dart';
import 'package:MOrder/views/PRODUCTSCATERGORY/produtCatergory.dart';
import 'package:MOrder/views/INVOICE/invoiceSetlement.dart';
import 'package:MOrder/views/MAKEORDERS/makeOrders.dart';
import 'package:MOrder/views/PRODUCTS/productCategory.dart';
import 'package:MOrder/views/CART/productRanges.dart';
import 'package:MOrder/views/DASHBOARD/mainDashboard.dart';
import 'package:MOrder/views/AUTH/supplier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  var GIVEN_NAME;
  var PROFILE_IMAGE;

  shareDate() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var givenName = localStorage.getString('GIVEN_NAME');
    var profileImage = localStorage.getString('PROFILE_IMAGE');
    setState(() {
      GIVEN_NAME = givenName;
      PROFILE_IMAGE = profileImage;
    });
  }

  @override
  void initState() {
    super.initState();
    shareDate();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(30.0),
            color: Colors.orange,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(PROFILE_IMAGE)),
                  ),
                ),
                Text(
                  GIVEN_NAME,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                Text(
                  "dulanjansej@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.orange,
            ),
            title: Text(
              "Dashboard",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                //return mainDashBoard("cat");
                return MainDashBoard(1);
              }))
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.add_shopping_cart,
          //     color: Colors.orange,
          //   ),
          //   title: Text(
          //     "My Order",
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onTap: () => {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          //       return MakeOder(1);
          //     }))
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.reorder,
              color: Colors.orange,
            ),
            title: Text(
              "My Orders",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                //return ShoppingPage();
                return AllProductRanges(1);
              }))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.monetization_on_sharp,
              color: Colors.orange,
            ),
            title: Text(
              "Outstanding",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return outStanding();
              }))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.speaker_notes_outlined,
              color: Colors.orange,
            ),
            title: Text(
              "Product Catalogue",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                //return ShoppingPage();
                return AllProductCatalogueRanges(1);
              }))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.supervised_user_circle,
              color: Colors.orange,
            ),
            title: Text("Supplier Details", style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return Supplier(1);
                  }
              ))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.speaker_notes_outlined,
              color: Colors.orange,
            ),
            title: Text(
              "Order History",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return OrderHistory();
              }))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.orange,
            ),
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return Login("","");
                  }
              ))
            },
          ),
        ],
      ),
    );
  }
}
