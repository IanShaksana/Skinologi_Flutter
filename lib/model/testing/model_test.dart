import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'model_test.g.dart';

@JsonSerializable()
class ModelTest {
  final DateTime date1;
  final DateTime date2;
  final DateTime date3;
  final DateTime date4;

  ModelTest({
    required this.date1,
    required this.date2,
    required this.date3,
    required this.date4,
  });

  factory ModelTest.fromJson(Map<String, dynamic> value) {
    return _$ModelTestFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelTestToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}
