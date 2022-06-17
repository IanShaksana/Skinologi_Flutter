import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'model_bag.g.dart';

@JsonSerializable()
class ModelBag {
  String? idBag;
  String? idPatient;

  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelBag({
    this.idBag,
    this.idPatient,
    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelBag.fromJson(Map<String, dynamic> value) {
    return _$ModelBagFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelBagToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}

@JsonSerializable()
class ModelBagDetail {
  String? idBagDetail;
  String? idBag;
  String? idInventory;
  int? quantity;

  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelBagDetail({
    this.idBagDetail,
    this.idBag,
    this.idInventory,
    this.quantity,
    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelBagDetail.fromJson(Map<String, dynamic> value) {
    return _$ModelBagDetailFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelBagDetailToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}
