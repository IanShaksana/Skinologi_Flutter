import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:replikasi_marketing_tracker/model/model_received.dart';
import 'package:replikasi_marketing_tracker/settings/shared_pref.dart';

class HttpHelper {
  late String url;

  // String baseUrl = '192.168.0.102:8081';
  // String baseUrl = '192.168.1.13:7001';
  // String baseUrl = '192.168.0.3:7001';
  
  String baseUrl = ':7001';
  // String baseUrl = '128.199.102.132:8081';
  late Map<String, dynamic> data;
  HttpHelper({required this.url});

  Future<bool> useHttpPost({required String dataEncrypt,required BuildContext context}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
          
    final sp = Provider.of<SharedPrefProvider>(context, listen: false);
      var apiUrl = Uri.http(sp.ipAddress+baseUrl, url);
      // var bodyValue = ModelRetCross(data: dataEncrypt).toJson();
      var bodyValue = dataEncrypt;
      debugPrint('THE URL : ' + url);
      debugPrint('THE Real URL : ' + apiUrl.toString());
      try {
        var response = await http.post(apiUrl, body: bodyValue);
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        data = jsonResponse;
        var message = jsonResponse['message'];
        var status = jsonResponse['status'];
        if (status == 1) {
          debugPrint(response.body);
          debugPrint('Message : $message.');
          return true;
        } else {
          debugPrint(
              'Request post failed with status: ${response.statusCode}.');
          debugPrint('Message : $message.');
          return false;
        }
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }

      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return false;
    }
  }

  Map<String, dynamic> getData() {
    return data;
  }

  ModelReceived getData2() {
    var value = getData();
    var json = jsonEncode(value['data']);

    var data = jsonDecode(json) as List;
    var message = value['message'];
    var status = value['status'];

    var model = ModelReceived(data: data, message: message, status: status);
    return model;
  }


  void useHttpGet(String headerObj, String headerVal) async {
    var url2 = Uri.http('192.168.0.3:8081', '/api/test/1');

    var response = await http.get(url2, headers: {headerObj: headerVal});

    if (response.statusCode == 200) {
      debugPrint(response.body);

      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = jsonResponse['message'];
      debugPrint('The data : $data.');
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }
  }
}
