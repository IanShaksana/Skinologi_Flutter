import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'model_ret_cross.g.dart';

@JsonSerializable()
class ModelRetCross {
  final String data;

  ModelRetCross({required this.data});

  factory ModelRetCross.fromJson(Map<String, dynamic> value) {
    return _$ModelRetCrossFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelRetCrossToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}