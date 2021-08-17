import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:MOrder/models/topTenProducts.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:MOrder/controllers/shopping_controller.dart';
import 'package:MOrder/controllers/cart_controller.dart';
import 'package:MOrder/views/MAKEORDERS/makeOrders.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashBoard extends StatefulWidget {
  final int productName;

  const MainDashBoard(this.productName);

  @override
  _MainDashBoardState createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  List<charts.Series<Products, String>> _seriesBarData;
  _generateData() {
    var barData = [
      new Products("Cookies", 19.5, Colors.lightBlueAccent),
      new Products("Cakes", 37.0, Colors.orangeAccent),
      new Products("Fruits", 49.0, Colors.lightGreenAccent),
      new Products("Chocolate", 67.8, Colors.lightBlueAccent),
    ];

    _seriesBarData.add(
      charts.Series(
          data: barData,
          domainFn: (Products products, _) => products.Targer_v,
          measureFn: (Products products, _) => products.Achieved_v,
          colorFn: (Products products, _) =>
              charts.ColorUtil.fromDartColor(products.color_v),
          id: "Daily Income",
          labelAccessorFn: (Products products, _) => '${products.Achieved_v}'),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesBarData = List<charts.Series<Products, String>>();
    _generateData();
  }

  Material myItems(IconData icon, String headline, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.black12,
      borderRadius: BorderRadius.circular(14.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        (headline),
                        style: TextStyle(color: Color(color), fontSize: 14.0),
                      ),
                    ),
                  ),
                  Material(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  final shoppingController = Get.put(ShoppingController());
  final cartControllert = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        actions: <Widget>[
          Badge(
            position: BadgePosition.topEnd(top: 0, end: 3),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            badgeColor: Colors.deepOrange,
            badgeContent: GetX<CartController>(
              builder: (controller) {
                return Text('${controller.itemCount}',
                  style: TextStyle(fontSize: 15,color: Colors.white),);
              },
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return MakeOder(1);
                  }));
                }
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FutureBuilder<List<TopTenProduct>>(
              future: getTenProduct(),
              builder: (context, snapshot) {
                print(snapshot.hasData);
                if (snapshot.hasData) {
                  print(snapshot.data.length);
                  var data = snapshot.data;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var imageIMAGE = data[index].productImage;
                            var baseURL ='https://demo.msalesapp.com/msales/resources/getBlob/';
                            var imageURL = baseURL + imageIMAGE;
                            return GestureDetector(
                              onTap: (){
                                print('${data[index].id}');
                              },
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    padding: EdgeInsets.all(8),
                                    width: 250,
                                    height: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(color: Colors.orange.withOpacity(0.3))
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    //padding: EdgeInsets.all(10.0),
                                                    //color: Colors.orangeAccent,
                                                    child: Text(
                                                      '${data[index].productName}',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.orangeAccent),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    '${data[index].id}',
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Image.network(
                                                imageURL,
                                                height: 100,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: data.length,
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Expanded(
            child: StaggeredGridView.count(
              crossAxisCount: 1,
              //crossAxisSpacing: 1.0,
              //mainAxisSpacing: 1.0,
              //padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: [
                // myItems(Icons.graphic_eq, "TARGET", 0XFFCD622B),
                // myItems(Icons.unarchive, "ACHIEVED", 0XFF1D852B),
                // myItems(Icons.account_balance_wallet, "BALANCE", 0XFF6D852B),
                // myItems(Icons.margin, "GP MARGIN", 0XFF7B622B),
                Container(
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                  // color: Colors.red,
                  child: charts.PieChart(
                    _seriesBarData,
                    animate: true,
                    animationDuration: Duration(seconds: 4),
                    behaviors: [
                      charts.DatumLegend(
                          outsideJustification:
                          charts.OutsideJustification.endDrawArea,
                          horizontalFirst: false,
                          desiredMaxRows: 2,
                          cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.purple.shadeDefault,
                              fontSize: 11))
                    ],
                    defaultRenderer: charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ]),
                  ),
                ),
                // myItems(Icons.account_balance_wallet, "BALANCE", 0XFF6D852B),
                // myItems(Icons.margin, "GP MARGIN", 0XFF7B622B),
              ],
              staggeredTiles: [
                // StaggeredTile.extent(1, 150.0),
                // StaggeredTile.extent(1, 150.0),
                // StaggeredTile.extent(1, 150.0),
                // StaggeredTile.extent(1, 150.0),
                StaggeredTile.extent(2, 200.0),
                // StaggeredTile.extent(1, 150.0),
                // StaggeredTile.extent(1, 150.0),
              ],
            )
          ),
          SizedBox(height: 10.0,),
          Expanded(
              child: StaggeredGridView.count(
                crossAxisCount: 1,
                //crossAxisSpacing: 1.0,
                //mainAxisSpacing: 1.0,
                //padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                children: [
                  // myItems(Icons.graphic_eq, "TARGET", 0XFFCD622B),
                  // myItems(Icons.unarchive, "ACHIEVED", 0XFF1D852B),
                  // myItems(Icons.account_balance_wallet, "BALANCE", 0XFF6D852B),
                  // myItems(Icons.margin, "GP MARGIN", 0XFF7B622B),
                  Container(
                    // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                    // color: Colors.red,
                    child: charts.BarChart(
                      _seriesBarData,
                      animate: true,
                      animationDuration: Duration(seconds: 4),
                      behaviors: [
                        charts.DatumLegend(
                            outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 2,
                            cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                            entryTextStyle: charts.TextStyleSpec(
                                color: charts.MaterialPalette.purple.shadeDefault,
                                fontSize: 11))
                      ],
                      barRendererDecorator: new charts.BarLabelDecorator<String>(),
                      // Hide domain axis.
                      domainAxis:
                      new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
                    ),
                  ),
                  // myItems(Icons.account_balance_wallet, "BALANCE", 0XFF6D852B),
                  // myItems(Icons.margin, "GP MARGIN", 0XFF7B622B),
                ],
                staggeredTiles: [
                  // StaggeredTile.extent(1, 150.0),
                  // StaggeredTile.extent(1, 150.0),
                  // StaggeredTile.extent(1, 150.0),
                  // StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(2, 200.0),
                  // StaggeredTile.extent(1, 150.0),
                  // StaggeredTile.extent(1, 150.0),
                ],
              )
          )
        ],
      ),
    );
  }

  Future<List<TopTenProduct>> getTenProduct() async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var accessToken = localStorage.getString('ACCESS_TOKEN');

    final List<TopTenProduct> products = [];

    var headers = {
      'Authorization':'Bearer ${accessToken}',
      'Content-Type': 'application/json',
      'Cookie': 'JSESSIONID=B2E911507B6EE95774EC0246B10F5F5F',
      'BusinessId': 'partner-1'
    };

    var response = await http.get(
        Uri.parse(
            'https://api.msalesapp.com/API/V1/TopSellingProducts'),
        headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var allProducts = json.decode(response.body)["products"];
      print(allProducts);

      for (int i = 0; i < allProducts.length; i++) {
        products.add(TopTenProduct.fromJson(allProducts[i]));
      }
    } else {
      print(response.reasonPhrase);
    }
    print(products.length);
    return products;
  }
}

class Products {
  String Targer_v;
  double Achieved_v;
  Color color_v;

  Products(this.Targer_v, this.Achieved_v, this.color_v);
}
