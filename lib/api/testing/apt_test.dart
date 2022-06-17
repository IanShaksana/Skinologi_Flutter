import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:replikasi_marketing_tracker/api/http_helper.dart';
import 'package:replikasi_marketing_tracker/model/model_received.dart';
import 'package:replikasi_marketing_tracker/util/encrypt_util.dart';

class ApiTest {
  Future<ModelReceived> getAll(BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/test/1/out');
    await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    return helper.getData2();
  }
}

final apiTest = ApiTest();
