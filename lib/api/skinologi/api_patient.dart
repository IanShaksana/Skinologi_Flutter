import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:replikasi_marketing_tracker/api/http_helper.dart';
import 'package:replikasi_marketing_tracker/model/model_received.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_appointment_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_bag_detail_inventory.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/util/encrypt_util.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_date_picker.dart';

class ApiPatient {
  Future<List<ModelPatient>> getAll(BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/patient/get/all');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelPatient.fromJson(e);
      }).toList();
      return json as List<ModelPatient>;
    } else {
      List<ModelPatient> empty = List.empty();
      return empty;
    }
  }

  Future<List<ModelBagDetailInventory>> getBag(
      String idPatient, BuildContext context) async {
    final body = jsonEncode({
      'id': idPatient,
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/patient/get/bag');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelBagDetailInventory.fromJson(e);
      }).toList();
      return json as List<ModelBagDetailInventory>;
    } else {
      List<ModelBagDetailInventory> empty = List.empty();
      return empty;
    }
  }

  Future<ModelPatient> getDetail(String idPatient, BuildContext context) async {
    final body = jsonEncode({
      'id': idPatient,
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/patient/get/detail');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);

    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelPatient.fromJson(e);
      }).toList();
      return json[0] as ModelPatient;
    } else {
      return ModelPatient();
    }
  }

  Future<void> create(
    String idPatient,
    String name,
    CustomDatePicker dob,
    String email,
    String address,
    String contact,
    String blood,
    String status,
    String rank,
    BuildContext context,
  ) async {
    var data = ModelPatient(
      idPatient: idPatient,
      name: name,
      dob: dob.getChoosen(),
      email: email,
      address: address,
      contact: contact,
      blood: blood,
      status: status,
      rank: rank,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/patient/create');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<void> edit(
    String idPatient,
    String name,
    CustomDatePicker dob,
    String email,
    String address,
    String contact,
    String blood,
    String status,
    String rank,
    int version,
    BuildContext context,
  ) async {
    var data = ModelPatient(
      idPatient: idPatient,
      name: name,
      dob: dob.getChoosen(),
      email: email,
      address: address,
      contact: contact,
      blood: blood,
      status: status,
      rank: rank,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/patient/edit');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<List<ModelAppointmentPatient>> getAllAppointment(
      BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/patient/appointment/get/all');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelAppointmentPatient.fromJson(e);
      }).toList();
      return json as List<ModelAppointmentPatient>;
    } else {
      List<ModelAppointmentPatient> empty = List.empty();
      return empty;
    }
  }

  Future<List<ModelAppointmentPatient>> getShortAppointment(
      BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/patient/appointment/get/short');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelAppointmentPatient.fromJson(e);
      }).toList();
      return json as List<ModelAppointmentPatient>;
    } else {
      List<ModelAppointmentPatient> empty = List.empty();
      return empty;
    }
  }

  Future<ModelReceived> getShortAppointment2(BuildContext context) async {
    final body = jsonEncode({
      'id': 'empty',
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/patient/appointment/get/short');
    await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    return helper.getData2();
  }

  Future<ModelAppointment> getDetailAppointment(
      String idAppointment, BuildContext context) async {
    final body = jsonEncode({
      'id': idAppointment,
    });

    var dataEncrypt = GenUtil().encryption(body);
    var helper = HttpHelper(url: '/api/patient/appointment/get/detail');
    final response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);

    if (response) {
      var value = (helper.getData());
      var data = jsonEncode(value['data']);
      var json = jsonDecode(data) as List;
      json = json.map((e) {
        return ModelAppointment.fromJson(e);
      }).toList();
      return json[0] as ModelAppointment;
    } else {
      return ModelAppointment();
    }
  }

  Future<void> createAppointment(
    String idAppointment,
    String idPatient,
    CustomDatePicker dob,
    CustomTimePicker time,
    String description,
    int version,
    BuildContext context,
  ) async {
    var data = ModelAppointment(
      idAppointment: idAppointment,
      idPatient: idPatient,
      date: dob.getChoosen(),
      time: time.getChoosen(),
      description: description,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    debugPrint(dataEncrypt);
    HttpHelper helper = HttpHelper(url: '/api/patient/appointment/create');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<void> editAppointment(
    String idAppointment,
    String idPatient,
    CustomDatePicker dob,
    CustomTimePicker time,
    String description,
    int version,
    BuildContext context,
  ) async {
    var data = ModelAppointment(
      idAppointment: idAppointment,
      idPatient: idPatient,
      date: dob.getChoosen(),
      time: time.getChoosen(),
      description: description,
      version: version,
    );
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/patient/appointment/edit');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      routeHelper.pop(context);
    }
  }

  Future<void> deleteAppointment(
    ModelAppointment model,
    BuildContext context,
  ) async {
    var data = model;
    var dataEncrypt = GenUtil().encryption(data.toJson());
    HttpHelper helper = HttpHelper(url: '/api/patient/appointment/delete');
    var response =
        await helper.useHttpPost(dataEncrypt: dataEncrypt, context: context);
    if (response) {
      // routeHelper.pop(context);
    }
  }
}

final apiPatient = ApiPatient();
