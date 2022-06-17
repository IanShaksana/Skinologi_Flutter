// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelPatient _$ModelPatientFromJson(Map<String, dynamic> json) => ModelPatient(
      idPatient: json['idPatient'] as String?,
      name: json['name'] as String?,
      dob: json['dob'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      contact: json['contact'] as String?,
      blood: json['blood'] as String?,
      status: json['status'] as String?,
      rank: json['rank'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastModifiedBy: json['lastModifiedBy'] as String?,
      lastModifiedAt: json['lastModifiedAt'] == null
          ? null
          : DateTime.parse(json['lastModifiedAt'] as String),
      version: json['version'] as int?,
    );

Map<String, dynamic> _$ModelPatientToJson(ModelPatient instance) =>
    <String, dynamic>{
      'idPatient': instance.idPatient,
      'name': instance.name,
      'dob': instance.dob,
      'email': instance.email,
      'address': instance.address,
      'contact': instance.contact,
      'blood': instance.blood,
      'status': instance.status,
      'rank': instance.rank,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };

ModelAppointment _$ModelAppointmentFromJson(Map<String, dynamic> json) =>
    ModelAppointment(
      idAppointment: json['idAppointment'] as String?,
      idPatient: json['idPatient'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastModifiedBy: json['lastModifiedBy'] as String?,
      lastModifiedAt: json['lastModifiedAt'] == null
          ? null
          : DateTime.parse(json['lastModifiedAt'] as String),
      version: json['version'] as int?,
    );

Map<String, dynamic> _$ModelAppointmentToJson(ModelAppointment instance) =>
    <String, dynamic>{
      'idAppointment': instance.idAppointment,
      'idPatient': instance.idPatient,
      'date': instance.date,
      'time': instance.time,
      'description': instance.description,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };
