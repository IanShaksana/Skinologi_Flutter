// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_treatment_tx_usage_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelTreatmentTxUsageInventory _$ModelTreatmentTxUsageInventoryFromJson(
        Map<String, dynamic> json) =>
    ModelTreatmentTxUsageInventory(
      treatmentTx: json['treatmentTx'] == null
          ? null
          : ModelTreatmentTx.fromJson(
              json['treatmentTx'] as Map<String, dynamic>),
      patient: json['patient'] == null
          ? null
          : ModelPatient.fromJson(json['patient'] as Map<String, dynamic>),
      treatmentUsage: json['treatmentUsage'] == null
          ? null
          : ModelTreatmentUsage.fromJson(
              json['treatmentUsage'] as Map<String, dynamic>),
      inventory: json['inventory'] == null
          ? null
          : ModelInventory.fromJson(json['inventory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModelTreatmentTxUsageInventoryToJson(
        ModelTreatmentTxUsageInventory instance) =>
    <String, dynamic>{
      'treatmentTx': instance.treatmentTx,
      'patient': instance.patient,
      'treatmentUsage': instance.treatmentUsage,
      'inventory': instance.inventory,
    };
