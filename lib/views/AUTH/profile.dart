import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:MOrder/views/AUTH/supplier.dart';
import 'package:MOrder/models/business.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final logoutAction;
  String name;
  String picture;

  Profile(this.logoutAction, this.name, this.picture);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Business> businessList = [];
  Business dropdownValue;
  //String picture = "https://s.gravatar.com/avatar/66cb0e36c3955fcc2e0480a012436a4f?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fdm.png";

  var USER_TOKEN;
  var GIVEN_NAME;
  var PROFILE_IMAGE;
  var ACCESS_TOKEN;

  shareDate() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userToken = localStorage.getString('USER_TOKEN');
    var givenName = localStorage.getString('GIVEN_NAME');
    var profileImage = localStorage.getString('PROFILE_IMAGE');
    setState(() {
      USER_TOKEN = userToken;
      GIVEN_NAME = givenName;
      PROFILE_IMAGE = profileImage;
    });
  }


  Future<void> getMyBusiness() async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var accessToken = localStorage.getString('ACCESS_TOKEN');
    final List<Business> business = [];

    var headers = {
      'X-AUTH-TOKEN': accessToken,
      'Content-Type': 'application/json'
    };

    var response = await http.post(
        Uri.parse(
            'https://central.msalesapp.com/central/modelng/performoperation/Federal/GetMyBuyingBusinesses'),
        body: json.encode({}),
        headers: headers);

    if (response.statusCode == 200) {
      var allBusiness = json.decode(response.body)["objects"]['Businesses'];

      for (int i = 0; i < allBusiness.length; i++) {
        business.add(Business.fromJson(allBusiness[i]));
      }
    } else {
      print(response.reasonPhrase);
    }

    print(response.body);
    setState(() {
      businessList = business;
    });
  }

  @override
  void initState() {
    super.initState();
    getMyBusiness();
    shareDate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Hi $GIVEN_NAME",
                        style: TextStyle(fontSize: 28.0),
                      ),
                      Text(
                        " Welcome",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ],
                  )
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(PROFILE_IMAGE ?? ''),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                DropdownButton<Business>(
                  value: dropdownValue,
                  hint: Text("Select Business"),
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onTap: (){
                    print("Clicked");
                  },
                  onChanged: (Business newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      // return mainDashBoard(newValue.id.toString());
                      return Supplier(newValue.id);
                    }));
                  },
                  items: businessList
                      .map<DropdownMenuItem<Business>>((Business value) {
                    return DropdownMenuItem<Business>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
