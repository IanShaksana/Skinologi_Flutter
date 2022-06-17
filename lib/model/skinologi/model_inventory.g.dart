// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelInventory _$ModelInventoryFromJson(Map<String, dynamic> json) =>
    ModelInventory(
      idInventory: json['idInventory'] as String?,
      name: json['name'] as String?,
      unit: json['unit'] as String?,
      description: json['description'] as String?,
      quantity: json['quantity'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      status: json['status'] as String?,
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

Map<String, dynamic> _$ModelInventoryToJson(ModelInventory instance) =>
    <String, dynamic>{
      'idInventory': instance.idInventory,
      'name': instance.name,
      'unit': instance.unit,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };

ModelInventoryTx _$ModelInventoryTxFromJson(Map<String, dynamic> json) =>
    ModelInventoryTx(
      idInventoryTx: json['idInventoryTx'] as String?,
      idInventory: json['idInventory'] as String?,
      quantity: json['quantity'] as int?,
      type: json['type'] as int?,
      source: json['source'] as String?,
      destination: json['destination'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      status: json['status'] as String?,
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

Map<String, dynamic> _$ModelInventoryTxToJson(ModelInventoryTx instance) =>
    <String, dynamic>{
      'idInventoryTx': instance.idInventoryTx,
      'idInventory': instance.idInventory,
      'quantity': instance.quantity,
      'type': instance.type,
      'source': instance.source,
      'destination': instance.destination,
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };
