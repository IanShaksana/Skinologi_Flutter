// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_received.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelReceived _$ModelReceivedFromJson(Map<String, dynamic> json) =>
    ModelReceived(
      data: json['data'] as List<dynamic>,
      message: json['message'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$ModelReceivedToJson(ModelReceived instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
    };
