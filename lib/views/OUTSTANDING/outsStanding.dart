import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';

class outStanding extends StatefulWidget {
  @override
  _outStandingState createState() => _outStandingState();
}

class _outStandingState extends State<outStanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outstandings'),
        backgroundColor: Colors.orange,
      ),
      drawer: MainDrawer(),
    );
  }
}
