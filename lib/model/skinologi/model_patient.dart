import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'model_patient.g.dart';

@JsonSerializable()
class ModelPatient {
  String? idPatient;
  String? name;
  String? dob;
  String? email;
  String? address;
  String? contact;
  String? blood;

  String? status;
  String? rank;

  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelPatient({
    this.idPatient,
    this.name,
    this.dob,
    this.email,
    this.address,
    this.contact,
    this.blood,
    this.status,
    this.rank,
    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelPatient.fromJson(Map<String, dynamic> value) {
    return _$ModelPatientFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelPatientToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}

@JsonSerializable()
class ModelAppointment {
  String? idAppointment;
  String? idPatient;
  String? date;
  String? time;
  String? description;

  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelAppointment({
    this.idAppointment,
    this.idPatient,
    this.date,
    this.time,
    this.description,
    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelAppointment.fromJson(Map<String, dynamic> value) {
    return _$ModelAppointmentFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelAppointmentToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}
