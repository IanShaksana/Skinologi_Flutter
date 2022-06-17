// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_treatment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelTreatment _$ModelTreatmentFromJson(Map<String, dynamic> json) =>
    ModelTreatment(
      idTreatment: json['idTreatment'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
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

Map<String, dynamic> _$ModelTreatmentToJson(ModelTreatment instance) =>
    <String, dynamic>{
      'idTreatment': instance.idTreatment,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };

ModelTreatmentTx _$ModelTreatmentTxFromJson(Map<String, dynamic> json) =>
    ModelTreatmentTx(
      idTreatmentTx: json['idTreatmentTx'] as String?,
      idPatient: json['idPatient'] as String?,
      anamnesis: json['anamnesis'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      status: json['status'] as String?,
      treatmentPrice: (json['treatmentPrice'] as num?)?.toDouble(),
      inventoryPrice: (json['inventoryPrice'] as num?)?.toDouble(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      realPrice: (json['realPrice'] as num?)?.toDouble(),
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

Map<String, dynamic> _$ModelTreatmentTxToJson(ModelTreatmentTx instance) =>
    <String, dynamic>{
      'idTreatmentTx': instance.idTreatmentTx,
      'idPatient': instance.idPatient,
      'anamnesis': instance.anamnesis,
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
      'status': instance.status,
      'treatmentPrice': instance.treatmentPrice,
      'inventoryPrice': instance.inventoryPrice,
      'totalPrice': instance.totalPrice,
      'discount': instance.discount,
      'realPrice': instance.realPrice,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };

ModelTreatmentDetail _$ModelTreatmentDetailFromJson(
        Map<String, dynamic> json) =>
    ModelTreatmentDetail(
      idTreatmentDetail: json['idTreatmentDetail'] as String?,
      idTreatmentTx: json['idTreatmentTx'] as String?,
      idTreatment: json['idTreatment'] as String?,
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

Map<String, dynamic> _$ModelTreatmentDetailToJson(
        ModelTreatmentDetail instance) =>
    <String, dynamic>{
      'idTreatmentDetail': instance.idTreatmentDetail,
      'idTreatmentTx': instance.idTreatmentTx,
      'idTreatment': instance.idTreatment,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };

ModelTreatmentUsage _$ModelTreatmentUsageFromJson(Map<String, dynamic> json) =>
    ModelTreatmentUsage(
      idTreatmentUsage: json['idTreatmentUsage'] as String?,
      idTreatmentTx: json['idTreatmentTx'] as String?,
      idInventory: json['idInventory'] as String?,
      totalQuantity: json['totalQuantity'] as int?,
      useQuantity: json['useQuantity'] as int?,
      realQuantity: json['realQuantity'] as int?,
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

Map<String, dynamic> _$ModelTreatmentUsageToJson(
        ModelTreatmentUsage instance) =>
    <String, dynamic>{
      'idTreatmentUsage': instance.idTreatmentUsage,
      'idTreatmentTx': instance.idTreatmentTx,
      'idInventory': instance.idInventory,
      'totalQuantity': instance.totalQuantity,
      'useQuantity': instance.useQuantity,
      'realQuantity': instance.realQuantity,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedAt': instance.lastModifiedAt?.toIso8601String(),
      'version': instance.version,
    };
