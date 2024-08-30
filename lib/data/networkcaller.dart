import 'dart:convert';

import 'dart:developer';
import 'package:http/http.dart';
import 'package:quiz_test/data/networkresponse.dart';


class Networkcall {
  static Future<Networkresponse> getRequest(String url) async {
    try {
      Response response = await get(
        Uri.parse(url), headers: {}
      );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return Networkresponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {

      } else {
        return Networkresponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return Networkresponse(false, -1, null);
  }

  Future<Networkresponse> postRequest(String url, Map<String, dynamic> body,
      {bool islogin = false}) async {

    try {
      print(body);
      Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(body),

      );
      print(response.statusCode);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        try{
          print(jsonDecode(response.body));

          return Networkresponse(
              true, response.statusCode, jsonDecode(response.body));
        }catch(e){
          print(e.toString());
        }
      } else if (response.statusCode == 401) {
        if (islogin == false) {
          gotoLogin();
        }
      } else {
        return Networkresponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return Networkresponse(false, -1, null);
  }

  Future<void> gotoLogin() async {}
}
