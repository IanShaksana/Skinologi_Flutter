import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
part 'model_appointment_patient.g.dart';

@JsonSerializable()
class ModelAppointmentPatient {

  ModelAppointment appointment;
  ModelPatient patient;

  ModelAppointmentPatient({
    required this.appointment,
    required this.patient,
  });

  factory ModelAppointmentPatient.fromJson(Map<String, dynamic> value) {
    return _$ModelAppointmentPatientFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelAppointmentPatientToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}