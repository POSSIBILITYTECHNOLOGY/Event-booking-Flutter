// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';

class ApiClient extends GetConnect {
  var imageFile = File('').obs;
  var imageUrl = ''.obs;

  updateImageFile(File value) {
    imageFile.value = value;
  }

  /*
  Using Get Default PUT method
  */

  Future<dynamic> callPostApi(String endPoint, Map<String, dynamic>? body, {String authToken = ""}) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
      "Authorization": "Bearer $authToken",
    };

    if (authToken.isNotEmpty) {
      headers = {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $authToken",
      };
    } else {
      // headers = {"Content-type": "application/json", "Accept": "application/json"};
    }

    String url = endPoint;

    log("value of body is $body");
    log("value of url is $url");
    print("value of apiHeader is $headers");
    try {
      var response = await post(
        url,
        body,
        headers: headers,
      );
      print("value of body is $body");
      print("value of url is $url");
      print("value of apiHeader is $headers");

      if (response.statusCode == 200) {
        print('callPostApi response.statusCode ==>\n ${response.statusCode}');

        print('callPostApi response.body ==>\n ${response.body}');

        print('callPostApi response Header ==>\n ${response.headers}');

        print('Run Successfully!!!!!');

        return response.body;
      } else {
        print('callPostApi response.statusText ==> ${response.statusText}');

        return response.body;
      }
    } catch (e) {
      print("callPostApi Exception ==> ${e.toString()}");
    }
    return false;
  }

  /*GET API CALL USING GET CONNECT*/

  // Postman Get Api

  Future<dynamic> callPostmanGetApi(String endPoint, {Map<String, dynamic>? query, String token = ''}) async {
    var withToken = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    var url = endPoint;

    try {
      var response = await get(
        endPoint,
        query: query,
        headers: withToken,
      );

      // print('callGetApi request token ==> \n $token');
      print("callGetApi request header ==> $withToken");
      log("callGetApi request url ==> $url");
      // print("callGetApi request query ==> $query");
      log("callGetApi request response ==> ${response.statusCode}");

      if (response.statusCode == 200) {
        print(response.statusCode);
        // print('callGetApi response.statusCode ==>\n ${response.statusCode}');

        // print('callGetApi response.body ==>\n ${response.body}');

        // print('callGetApi response Header ==>\n ${response.headers}');

        log('Run Successfully!!!!!');
        return response.body;
      } else {
        log('callGetApi Error response.statusText ==> ${response.statusText}');

        return response.body;
      }
    } catch (e) {
      log('callGetApi Exception ==> $e');
    }
  }

  Future<dynamic> callDeleteApi(String endPoint, {Map<String, dynamic>? query, String token = ''}) async {
    var withToken = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    var url = endPoint;

    try {
      var response = await delete(
        endPoint,
        query: query,
        headers: withToken,
      );

      // print('callGetApi request token ==> \n $token');
      print("callDeleteApi request header ==> $withToken");
      log("callDeleteApi request url ==> $url");
      // print("callDeleteApi request query ==> $query");
      log("callDeleteApi request response ==> ${response.statusCode}");

      if (response.statusCode == 200) {
        print(response.statusCode);
        // print('callDeleteApi response.statusCode ==>\n ${response.statusCode}');

        // print('callDeleteApi response.body ==>\n ${response.body}');

        // print('callDeleteApi response Header ==>\n ${response.headers}');

        log('Run Successfully!!!!!');
        return response.body;
      } else {
        log('callDeleteApi Error response.statusText ==> ${response.statusText}');

        return response.body;
      }
    } catch (e) {
      log('callDeleteApi Exception ==> $e');
    }
  }
}
