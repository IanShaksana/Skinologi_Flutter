import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:replikasi_marketing_tracker/api/http_helper.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_treatment.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_treatment_tx_treatment_detail.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_treatment_tx_usage_inventory.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/util/encrypt_util.dart';

class ApiTreatment {
  Future<List<ModelTreatment>> getAll(BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/treatment/get/all');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelTreatment.fromJson(e);
      }).toList();
      return json as List<ModelTreatment>;
    } else {
      List<ModelTreatment> empty = List.empty();
      return empty;
    }
  }

  Future<ModelTreatment> getDetail(
      String idTreatment, BuildContext context) async {
    final body = jsonEncode({
      'id': idTreatment,
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/treatment/get/detail');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);

    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelTreatment.fromJson(e);
      }).toList();
      return json[0] as ModelTreatment;
    } else {
      return ModelTreatment();
    }
  }

  Future<void> create(
    String idTreatment,
    String name,
    String description,
    double price,
    BuildContext context,
  ) async {
    var data = ModelTreatment(
      idTreatment: idTreatment,
      name: name,
      description: description,
      price: price,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/treatment/create');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<void> edit(
    String idTreatment,
    String name,
    String description,
    double price,
    int version,
    BuildContext context,
  ) async {
    var data = ModelTreatment(
      idTreatment: idTreatment,
      name: name,
      description: description,
      price: price,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/treatment/edit');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<List<ModelTreatmentTxTreatmentDetail>> getAllTx(BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/treatment/tx/get/all');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelTreatmentTxTreatmentDetail.fromJson(e);
      }).toList();
      return json as List<ModelTreatmentTxTreatmentDetail>;
    } else {
      List<ModelTreatmentTxTreatmentDetail> empty = List.empty();
      return empty;
    }
  }

  Future<List<ModelTreatmentTxTreatmentDetail>> getAllTxByPerson(
      String idPatient, BuildContext context) async {
    final body = jsonEncode({
      'id': idPatient,
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/treatment/tx/get/all/by/person');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelTreatmentTxTreatmentDetail.fromJson(e);
      }).toList();
      return json as List<ModelTreatmentTxTreatmentDetail>;
    } else {
      List<ModelTreatmentTxTreatmentDetail> empty = List.empty();
      return empty;
    }
  }

  Future<ModelTreatmentTxTreatmentDetail> getDetailTx(
      String idTreatmentTx, BuildContext context) async {
    final body = jsonEncode({
      'id': idTreatmentTx,
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/treatment/tx/get/detail');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);

    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelTreatmentTxTreatmentDetail.fromJson(e);
      }).toList();
      return json[0] as ModelTreatmentTxTreatmentDetail;
    } else {
      return ModelTreatmentTxTreatmentDetail();
    }
  }

  Future<void> createTx(
    ModelTreatmentTx treatmentTx,
    ModelPatient patient,
    List<ModelTreatment> treatment,
    List<ModelInventoryTx> inventoryTx,
    BuildContext context,
  ) async {
    var data = ModelTreatmentTxTreatmentDetail(
      treatmentTx: treatmentTx,
      patient: patient,
      treatment: treatment,
      inventoryTx: inventoryTx,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    // dataEncrypt = dataEncrypt.replaceAll(r'\', '');
    dataEncrypt = json.decode(dataEncrypt).toString();
    debugPrint(dataEncrypt);
    HttpHelper helper = HttpHelper(url: '/api/treatment/tx/create');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<void> deleteTx(
    ModelTreatmentTx treatmentTx,
    BuildContext context,
  ) async {
    var data = treatmentTx;
    var dataEncrypt = GenUtil().encryption(data.toJson());
    // dataEncrypt = dataEncrypt.replaceAll(r'\', '');
    // dataEncrypt = json.decode(dataEncrypt).toString();
    debugPrint(dataEncrypt);
    HttpHelper helper = HttpHelper(url: '/api/treatment/tx/delete');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      // routeHelper.pop(context);
    }
  }

  Future<List<ModelTreatmentTxUsageInventory>> getUsageTx(
    ModelTreatmentTx treatmentTx,
    BuildContext context,
  ) async {
    var data = treatmentTx;
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/treatment/tx/usage/get');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelTreatmentTxUsageInventory.fromJson(e);
      }).toList();
      return json as List<ModelTreatmentTxUsageInventory>;
    } else {
      List<ModelTreatmentTxUsageInventory> empty = List.empty();
      return empty;
    }
  }

  Future<void> verif1UsageTx(
    ModelTreatmentTx treatmentTx,
    List<ModelTreatmentUsage> treatmentUsage,
    BuildContext context,
  ) async {
    var data = ModelTreatmentTxTreatmentDetail(
      treatmentTx: treatmentTx,
      treatmentUsage: treatmentUsage,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    // dataEncrypt = dataEncrypt.replaceAll(r'\', '');
    dataEncrypt = json.decode(dataEncrypt).toString();
    debugPrint(dataEncrypt);
    HttpHelper helper = HttpHelper(url: '/api/treatment/tx/usage/verif1');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<void> verif2UsageTx(
    ModelTreatmentTx treatmentTx,
    BuildContext context,
  ) async {
    var data = treatmentTx;
    var dataEncrypt = GenUtil().encryption(data.toJson());
    // dataEncrypt = dataEncrypt.replaceAll(r'\', '');
    // dataEncrypt = json.decode(dataEncrypt).toString();
    debugPrint(dataEncrypt);
    HttpHelper helper = HttpHelper(url: '/api/treatment/tx/usage/verif2');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      // routeHelper.pop(context);
    }
  }

  Future<void> verifTx(
    ModelTreatmentTx treatmentTx,
    BuildContext context,
  ) async {
    var data = treatmentTx;
    var dataEncrypt = GenUtil().encryption(data.toJson());
    // dataEncrypt = dataEncrypt.replaceAll(r'\', '');
    // dataEncrypt = json.decode(dataEncrypt).toString();
    debugPrint(dataEncrypt);
    HttpHelper helper = HttpHelper(url: '/api/treatment/tx/verif');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      // routeHelper.pop(context);
    }
  }

  Future<void> calculateTx(
    ModelTreatmentTx treatmentTx,
    bool back,
    BuildContext context,
  ) async {
    var data = treatmentTx;
    var dataEncrypt = GenUtil().encryption(data.toJson());
    // dataEncrypt = dataEncrypt.replaceAll(r'\', '');
    // dataEncrypt = json.decode(dataEncrypt).toString();
    debugPrint(dataEncrypt);
    HttpHelper helper = HttpHelper(url: '/api/treatment/tx/calculate');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      if (back) {
        routeHelper.pop(context);
      }
    }
  }

  Future<void> completeTx(
    ModelTreatmentTx treatmentTx,
    BuildContext context,
  ) async {
    var data = treatmentTx;
    var dataEncrypt = GenUtil().encryption(data.toJson());
    // dataEncrypt = dataEncrypt.replaceAll(r'\', '');
    // dataEncrypt = json.decode(dataEncrypt).toString();
    debugPrint(dataEncrypt);
    HttpHelper helper = HttpHelper(url: '/api/treatment/tx/complete');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      // routeHelper.pop(context);
    }
  }

  // Future<List<ModelTreatment>> getAllTxByPerson(String idpatient) async {
  //   final body = jsonEncode({
  //     'id': idpatient,
  //   });

  //   var dataEncrypt = GenUtil().encryption(body);
  //   var helper = HttpHelper(url: '/api/treatment/tx/get/all/by/person');
  //   final response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
  //   if (response) {
  //     var value = (helper.getData());
  //     var data = jsonEncode(value['data']);
  //     var json = jsonDecode(data) as List;
  //     json = json.map((e) {
  //       return ModelTreatment.fromJson(e);
  //     }).toList();
  //     return json as List<ModelTreatment>;
  //   } else {
  //     List<ModelTreatment> empty = List.empty();
  //     return empty;
  //   }
  // }

  // Future<ModelTreatment> getDetailTx(String idTreatment) async {
  //   final body = jsonEncode({
  //     'id': idTreatment,
  //   });

  //   var dataEncrypt = GenUtil().encryption(body);
  //   var helper = HttpHelper(url: '/api/treatment/get/detail');
  //   final response = await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);

  //   if (response) {
  //     var value = (helper.getData());
  //     var data = jsonEncode(value['data']);
  //     var json = jsonDecode(data) as List;
  //     json = json.map((e) {
  //       return ModelTreatment.fromJson(e);
  //     }).toList();
  //     return json[0] as ModelTreatment;
  //   } else {
  //     return ModelTreatment();
  //   }
  // }

}

final apiTreatment = ApiTreatment();
