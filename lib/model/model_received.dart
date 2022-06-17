import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'model_received.g.dart';

@JsonSerializable()
class ModelReceived {
  final List<dynamic> data;
  final String message;
  final int status;

  ModelReceived({required this.data, required this.message, required this.status});

  factory ModelReceived.fromJson(Map<String, dynamic> value) {
    return _$ModelReceivedFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelReceivedToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}