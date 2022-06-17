// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_bag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelBag _$ModelBagFromJson(Map<String, dynamic> json) => ModelBag(
      idBag: json['idBag'] as String?,
      idPatient: json['idPatient'] as String?,
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

Map<String, dynamic> _$ModelBagToJson(ModelBag instance) => <String, dynamic>{
      'idBag': instance.idBag,
      'idPatient': instance.idPatient,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };

ModelBagDetail _$ModelBagDetailFromJson(Map<String, dynamic> json) =>
    ModelBagDetail(
      idBagDetail: json['idBagDetail'] as String?,
      idBag: json['idBag'] as String?,
      idInventory: json['idInventory'] as String?,
      quantity: json['quantity'] as int?,
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

Map<String, dynamic> _$ModelBagDetailToJson(ModelBagDetail instance) =>
    <String, dynamic>{
      'idBagDetail': instance.idBagDetail,
      'idBag': instance.idBag,
      'idInventory': instance.idInventory,
      'quantity': instance.quantity,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };
