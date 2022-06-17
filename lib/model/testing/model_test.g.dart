// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelTest _$ModelTestFromJson(Map<String, dynamic> json) => ModelTest(
      date1: DateTime.parse(json['date1'] as String),
      date2: DateTime.parse(json['date2'] as String),
      date3: DateTime.parse(json['date3'] as String),
      date4: DateTime.parse(json['date4'] as String),
    );

Map<String, dynamic> _$ModelTestToJson(ModelTest instance) => <String, dynamic>{
      'date1': instance.date1.toIso8601String(),
      'date2': instance.date2.toIso8601String(),
      'date3': instance.date3.toIso8601String(),
      'date4': instance.date4.toIso8601String(),
    };
