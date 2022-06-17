import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'model_treatment.g.dart';

@JsonSerializable()
class ModelTreatment {
  String? idTreatment;
  String? name;
  String? description;
  double? price;
  String? status;
  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelTreatment({
    this.idTreatment,
    this.name,
    this.description,
    this.price,
    this.status,
    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelTreatment.fromJson(Map<String, dynamic> value) {
    return _$ModelTreatmentFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelTreatmentToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }

  Map<String, dynamic> toJson2() => _$ModelTreatmentToJson(this);
}

@JsonSerializable()
class ModelTreatmentTx {
  String? idTreatmentTx;
  String? idPatient;
  String? anamnesis;
  DateTime? date;
  String? description;
  String? status;

  double? treatmentPrice;
  double? inventoryPrice;
  double? totalPrice;
  double? discount;
  double? realPrice;

  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelTreatmentTx({
    this.idTreatmentTx,
    this.idPatient,
    this.anamnesis,
    this.date,
    this.description,
    this.status,

    this.treatmentPrice,
    this.inventoryPrice,
    this.totalPrice,
    this.discount,
    this.realPrice,

    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelTreatmentTx.fromJson(Map<String, dynamic> value) {
    return _$ModelTreatmentTxFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelTreatmentTxToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}

@JsonSerializable()
class ModelTreatmentDetail {
  String? idTreatmentDetail;
  String? idTreatmentTx;
  String? idTreatment;

  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelTreatmentDetail({
    this.idTreatmentDetail,
    this.idTreatmentTx,
    this.idTreatment,
    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelTreatmentDetail.fromJson(Map<String, dynamic> value) {
    return _$ModelTreatmentDetailFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelTreatmentDetailToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}

@JsonSerializable()
class ModelTreatmentUsage {
  String? idTreatmentUsage;
  String? idTreatmentTx;
  String? idInventory;

  int? totalQuantity;
  int? useQuantity;
  int? realQuantity;

  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelTreatmentUsage({
    this.idTreatmentUsage,
    this.idTreatmentTx,
    this.idInventory,
    this.totalQuantity,
    this.useQuantity,
    this.realQuantity,
    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelTreatmentUsage.fromJson(Map<String, dynamic> value) {
    return _$ModelTreatmentUsageFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelTreatmentUsageToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}
