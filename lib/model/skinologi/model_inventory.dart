import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'model_inventory.g.dart';

@JsonSerializable()
class ModelInventory {
  String? idInventory;
  String? name;
  String? unit;
  String? description;
  int? quantity;
  double? price;
  String? status;

  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelInventory({
    this.idInventory,
    this.name,
    this.unit,
    this.description,
    this.quantity,
    this.price,
    this.status,
    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelInventory.fromJson(Map<String, dynamic> value) {
    return _$ModelInventoryFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelInventoryToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}

@JsonSerializable()
class ModelInventoryTx {
  String? idInventoryTx;
  String? idInventory;
  int? quantity;
  int? type;
  String? source;
  String? destination;
  DateTime? date;
  String? description;
  String? status;

  String? createdBy;
  DateTime? createdAt;
  String? lastModifiedBy;
  DateTime? lastModifiedAt;
  int? version;

  ModelInventoryTx({
    this.idInventoryTx,
    this.idInventory,
    this.quantity,
    this.type,
    this.source,
    this.destination,
    this.date,
    this.description,
    this.status,
    this.createdBy,
    this.createdAt,
    this.lastModifiedBy,
    this.lastModifiedAt,
    this.version,
  });

  factory ModelInventoryTx.fromJson(Map<String, dynamic> value) {
    return _$ModelInventoryTxFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelInventoryTxToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}
