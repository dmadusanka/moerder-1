import 'package:flutter/material.dart';
import 'productsTab.dart';

class GridProducts extends StatefulWidget {
  @override
  _GridProductsState createState() => _GridProductsState();
}

class _GridProductsState extends State<GridProducts>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override

  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 20.0),
      children: [
        SizedBox(height: 15.0,),
        Text("Product Ranges",
          style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 42.0,
              fontWeight: FontWeight.bold
          ),),
        SizedBox(height: 15.0,),
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Colors.black,
          isScrollable: true,
          labelPadding: EdgeInsets.only(right: 45.0),
          unselectedLabelColor: Colors.lightBlueAccent,
          tabs: [
            Tab(
              child: Text('Cookies',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0),),
            ),
            Tab(
              child: Text('Cakes',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0),),
            ),
            Tab(
              child: Text('Ice Cream',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0),),
            )
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height - 30.0,
          width: double.infinity,
          child: TabBarView(
            controller: _tabController,
            children: [
              ProductsTabs(),
              ProductsTabs(),
              ProductsTabs()
            ],
          ),
        ),
        SizedBox(height: 15.0,),
      ],
    );
  }
}
