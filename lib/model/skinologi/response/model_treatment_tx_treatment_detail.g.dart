// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_treatment_tx_treatment_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelTreatmentTxTreatmentDetail _$ModelTreatmentTxTreatmentDetailFromJson(
        Map<String, dynamic> json) =>
    ModelTreatmentTxTreatmentDetail(
      treatmentTx: json['treatmentTx'] == null
          ? null
          : ModelTreatmentTx.fromJson(
              json['treatmentTx'] as Map<String, dynamic>),
      patient: json['patient'] == null
          ? null
          : ModelPatient.fromJson(json['patient'] as Map<String, dynamic>),
      treatment: (json['treatment'] as List<dynamic>?)
          ?.map((e) => ModelTreatment.fromJson(e as Map<String, dynamic>))
          .toList(),
      treatmentDetail: (json['treatmentDetail'] as List<dynamic>?)
          ?.map((e) => ModelTreatmentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      treatmentUsage: (json['treatmentUsage'] as List<dynamic>?)
          ?.map((e) => ModelTreatmentUsage.fromJson(e as Map<String, dynamic>))
          .toList(),
      inventoryTx: (json['inventoryTx'] as List<dynamic>?)
          ?.map((e) => ModelInventoryTx.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelTreatmentTxTreatmentDetailToJson(
        ModelTreatmentTxTreatmentDetail instance) =>
    <String, dynamic>{
      'treatmentTx': instance.treatmentTx,
      'patient': instance.patient,
      'treatment': instance.treatment,
      'treatmentDetail': instance.treatmentDetail,
      'treatmentUsage': instance.treatmentUsage,
      'inventoryTx': instance.inventoryTx,
    };
