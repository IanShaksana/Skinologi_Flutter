// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_appointment_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelAppointmentPatient _$ModelAppointmentPatientFromJson(
        Map<String, dynamic> json) =>
    ModelAppointmentPatient(
      appointment: ModelAppointment.fromJson(
          json['appointment'] as Map<String, dynamic>),
      patient: ModelPatient.fromJson(json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModelAppointmentPatientToJson(
        ModelAppointmentPatient instance) =>
    <String, dynamic>{
      'appointment': instance.appointment,
      'patient': instance.patient,
    };
