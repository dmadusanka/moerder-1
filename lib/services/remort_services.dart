import 'dart:io';
import 'package:MOrder/models/productCatagories.dart';
import 'package:http/http.dart' as http;

class RemoteService{
  static var client = http.Client();

  // 'Content-Type': 'application/json',
  // 'Accept': 'application/json',
  // 'Authorization': 'Bearer $token',

  static Future<List<Product>> fetchProductCategories() async{
    var URL = Uri.parse("https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline");
    var token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkJEU2pBYnRPYWhFMEQtSjFmTXZ6MyJ9.eyJodHRwczovL3d3dy5tc2FsZXMuY29tL2VtYWlsIjoibWFuanVrYXNAeWFob28uY29tIiwiaHR0cHM6Ly93d3cubXNhbGVzLmNvbS9lbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDVmMGY5MmQyODZjYWU2MDAxMzFkZjdiMCIsImF1ZCI6WyJodHRwOi8vcHVibGljLmFwaS5tc2FsZXNhcHAuY29tIiwiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTYxNzgzODk4MywiZXhwIjoxNjE3OTI1MzgzLCJhenAiOiJCN0ZObXV2ZVRjZG4zZWthcVQ3eU1PZUs0Szgwd1FpOCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.htOLh9WAi0-DyWhcKQM-DkHFQNIMDVU5AW10XA1WS9fwspmpRPW1esHQAIVrkvaPR78weUThPdmOl9uxdUR4qahr8dN9sbHHhg8pGTHapHkvNMFwPD9kM31CMvYnJK0t1VeyuO5qy6T5yJTuBQP5wEU3dQqqfNig-k04Z0144lQ4QgjiWZJbFk0ZfmfgY9Rg2iOv7xiJF4t8r2lr_aSwtm6aJglMsZTGWfS4QcDFAuC75SC7g3g24z3pnDZ4W4CZ-1TOjHiFSk7aRIcpDGXNwGQPF3TusR8T6PsyZmiW6MGptFbZRSoPT4isDSgbupNsz1pivvZ0j1SrXlGoYwKV5w";
    var response = await client.get(URL);
    if(response.statusCode == 200){
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}

// import 'dart:io';
// import 'package:MOrder/models/productCatagories.dart';
// import 'package:http/http.dart' as http;
//
// class RemoteService{
//   static var client = http.Client();
//
//   // 'Content-Type': 'application/json',
//   // 'Accept': 'application/json',
//   // 'Authorization': 'Bearer $token',
//
//   static Future<List<Product>> fetchProductCategories() async{
//     var headers = {
//       'X-AUTH-TOKEN': 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkJEU2pBYnRPYWhFMEQtSjFmTXZ6MyJ9.eyJodHRwczovL3d3dy5tc2FsZXMuY29tL2VtYWlsIjoibWFuanVrYXNAeWFob28uY29tIiwiaHR0cHM6Ly93d3cubXNhbGVzLmNvbS9lbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDVmMGY5MmQyODZjYWU2MDAxMzFkZjdiMCIsImF1ZCI6WyJodHRwOi8vcHVibGljLmFwaS5tc2FsZXNhcHAuY29tIiwiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTYxNzgzODk4MywiZXhwIjoxNjE3OTI1MzgzLCJhenAiOiJCN0ZObXV2ZVRjZG4zZWthcVQ3eU1PZUs0Szgwd1FpOCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.htOLh9WAi0-DyWhcKQM-DkHFQNIMDVU5AW10XA1WS9fwspmpRPW1esHQAIVrkvaPR78weUThPdmOl9uxdUR4qahr8dN9sbHHhg8pGTHapHkvNMFwPD9kM31CMvYnJK0t1VeyuO5qy6T5yJTuBQP5wEU3dQqqfNig-k04Z0144lQ4QgjiWZJbFk0ZfmfgY9Rg2iOv7xiJF4t8r2lr_aSwtm6aJglMsZTGWfS4QcDFAuC75SC7g3g24z3pnDZ4W4CZ-1TOjHiFSk7aRIcpDGXNwGQPF3TusR8T6PsyZmiW6MGptFbZRSoPT4isDSgbupNsz1pivvZ0j1SrXlGoYwKV5w',
//       'Content-Type': 'application/json',
//       'Cookie': 'JSESSIONID=9769E5FD4947DAA37CD08AB1F12A9F71'
//     };
//
//     var URL = Uri.parse("https://central.msalesapp.com/central/modelng/performoperation/Federal/GetMySuppliers");
//     var response = await client.post(URL);
//     if(response.statusCode == 200){
//       var jsonString = response.body;
//       return productFromJson(jsonString);
//     } else {
//       print(response.statusCode);
//       return null;
//     }
//   }
// }