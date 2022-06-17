import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:replikasi_marketing_tracker/api/http_helper.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_inventory_tx.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/util/encrypt_util.dart';

class ApiInventory {
  Future<List<ModelInventory>> getAll(BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/inventory/get/all');
    final response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelInventory.fromJson(e);
      }).toList();
      return json as List<ModelInventory>;
    } else {
      List<ModelInventory> empty = List.empty();
      return empty;
    }
  }

  Future<List<ModelInventory>> getShort(BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/inventory/get/short');
    final response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelInventory.fromJson(e);
      }).toList();
      return json as List<ModelInventory>;
    } else {
      List<ModelInventory> empty = List.empty();
      return empty;
    }
  }

  Future<ModelInventory> getDetail(String idInventory, BuildContext context) async {
    final body = jsonEncode({
      'id': idInventory,
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/inventory/get/detail');
    final response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);

    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelInventory.fromJson(e);
      }).toList();
      return json[0] as ModelInventory;
    } else {
      return ModelInventory();
    }
  }

  Future<void> create(
    String idInventory,
    String name,
    String unit,
    String description,
    int quantity,
    double price,
    String status,
    int version,
    BuildContext context,
  ) async {
    var data = ModelInventory(
      idInventory: idInventory,
      name: name,
      unit: unit,
      description: description,
      quantity: quantity,
      price: price,
      status: status,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/inventory/create');
    var response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<void> edit(
    String idInventory,
    String name,
    String unit,
    String description,
    int quantity,
    double price,
    String status,
    int version,
    BuildContext context,
  ) async {
    var data = ModelInventory(
      idInventory: idInventory,
      name: name,
      unit: unit,
      description: description,
      quantity: quantity,
      price: price,
      status: status,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/inventory/edit');
    var response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<List<ModelInventoryTxCustom>> getAllTx(BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/inventory/tx/get/all');
    final response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelInventoryTxCustom.fromJson(e);
      }).toList();
      return json as List<ModelInventoryTxCustom>;
    } else {
      List<ModelInventoryTxCustom> empty = List.empty();
      return empty;
    }
  }

  Future<ModelInventoryTxCustom> getDetailTx(String idInventoryTx, BuildContext context) async {
    final body = jsonEncode({
      'id': idInventoryTx,
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/inventory/tx/get/detail');
    final response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);

    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelInventoryTxCustom.fromJson(e);
      }).toList();
      return json[0] as ModelInventoryTxCustom;
    } else {
      return ModelInventoryTxCustom(
          inventory: ModelInventory(),
          inventoryTx: ModelInventoryTx(),
          patient: ModelPatient());
    }
  }

  Future<void> createTx(
    String idInventoryTx,
    String idInventory,
    int quantity,
    String type,
    String source,
    String destination,
    DateTime date,
    String description,
    String status,
    int version,
    BuildContext context,
  ) async {
    int typeFinal = 0;
    switch (type) {
      case 'Add from Distributor':
        typeFinal = 1;
        break;

      case 'Add from Bag':
        typeFinal = 2;
        break;

      case 'Loss to Bag':
        typeFinal = 3;
        break;

      case 'Gone':
        typeFinal = 4;
        break;

      default:
        break;
    }
    var data = ModelInventoryTx(
      idInventoryTx: idInventoryTx,
      idInventory: idInventory,
      quantity: quantity,
      type: typeFinal,
      source: source,
      destination: destination,
      description: description,
      status: status,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/inventory/tx/create');
    var response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<void> editTx(
    String idInventoryTx,
    String idInventory,
    int quantity,
    String type,
    String source,
    String destination,
    DateTime date,
    String description,
    String status,
    int version,
    BuildContext context,
  ) async {
    int typeFinal = 0;
    switch (type) {
      case 'Add from Distributor':
        typeFinal = 1;
        break;

      case 'Add from Bag':
        typeFinal = 2;
        break;

      case 'Loss to Bag':
        typeFinal = 3;
        break;

      case 'Gone':
        typeFinal = 4;
        break;

      default:
        break;
    }
    var data = ModelInventoryTx(
      idInventoryTx: idInventoryTx,
      idInventory: idInventory,
      quantity: quantity,
      type: typeFinal,
      source: source,
      destination: destination,
      // date: date,
      description: description,
      status: status,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/inventory/tx/edit');
    var response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<void> deleteTx(
    String idInventoryTx,
    int version,
    BuildContext context,
  ) async {
    var data = ModelInventoryTx(
      idInventoryTx: idInventoryTx,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/inventory/tx/delete');
    var response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      // routeHelper.pop(context);
    }
  }

  Future<void> verifTx(
    String idInventoryTx,
    String idInventory,
    int quantity,
    int type,
    String source,
    String destination,
    DateTime date,
    String description,
    String status,
    int version,
    BuildContext context,
  ) async {
    var data = ModelInventoryTx(
      idInventoryTx: idInventoryTx,
      idInventory: idInventory,
      quantity: quantity,
      type: type,
      source: source,
      destination: destination,
      date: date,
      description: description,
      status: status,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/inventory/tx/verif');
    var response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      // routeHelper.pop(context);
    }
  }
}

final apiInventory = ApiInventory();
