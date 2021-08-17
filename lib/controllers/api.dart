import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

//------------------------

import 'package:MOrder/models/product.dart';
import 'package:MOrder/models/business.dart';
import 'package:shared_preferences/shared_preferences.dart';

//----------------------------



//GET PRODUCTS
Future<List<Product>> getProduct(String categoryId) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var accessToken = localStorage.getString('ACCESS_TOKEN');
  final List<Product> products = [];

  var headers = {
    'Authorization':
    'Bearer $accessToken',
    'Content-Type': 'application/json',
    'Cookie': 'JSESSIONID=B2E911507B6EE95774EC0246B10F5F5F',
    'BusinessId': 'partner-1'
  };

  var response = await http.get(
      Uri.parse(
          'https://api.msalesapp.com/API/V1/Products?CategoryId=$categoryId'),
      headers: headers);
  print(response.statusCode);
  if (response.statusCode == 200) {
    var allProducts = json.decode(response.body)["products"];
    print(allProducts);

    for (int i = 0; i < allProducts.length; i++) {
      products.add(Product.fromJson(allProducts[i]));
    }
  } else {
    print(response.reasonPhrase);
  }
  print(products.length);
  return products;
}


//GET BUSINESS API
Future<void> getMyBusiness() async {
  final List<Business> business = [];

  var headers = {
    'X-AUTH-TOKEN':
    'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkJEU2pBYnRPYWhFMEQtSjFmTXZ6MyJ9.eyJodHRwczovL3d3dy5tc2FsZXMuY29tL2VtYWlsIjoiZHVsYW5qYW5zZWpAZ21haWwuY29tIiwiaHR0cHM6Ly93d3cubXNhbGVzLmNvbS9lbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDYwNzAwYzgyMGE0YjU1MDA2OTJkYjgyOSIsImF1ZCI6WyJodHRwOi8vcHVibGljLmFwaS5tc2FsZXNhcHAuY29tIiwiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTYyOTExMzgzOSwiZXhwIjoxNjI5MjAwMjM5LCJhenAiOiJCN0ZObXV2ZVRjZG4zZWthcVQ3eU1PZUs0Szgwd1FpOCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.kZfPI0zi3v-VaX6MN10pIyK_HS4Ttt98HZ7YgYg4h_kGvqQfO57Z7WqJwPHO3rLn-eeFIX8NvE48D2G79BmjEcMeFYBZDaUOWsM9NRAi2CALEaYhgMEJmyNb8tyDHWI0oLOcMMIagvc22kK7ST4gJOiNDk4UAgH_GBBZRLLibSzPi9wh3GBbFXbDMbot_BAwyRHTBl25DUCMQvqmPlXXlZlwo6oofHwU8qjLqgpP4m74_9cYiUq6CxeWhMHzNqfrUkeBpYXGFmsdmJ11b2C6qM2T-TRZ-AGUFI1NPA7GYEcJx1v2A4o-4Xl7pmiJDYTKCau66CC9ehyu8c9JNWvZag',
    'Content-Type': 'application/json',
    'Cookie': 'JSESSIONID=B2E911507B6EE95774EC0246B10F5F5F'
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
  // setState(() {
  //   businessList = business;
  // });
}