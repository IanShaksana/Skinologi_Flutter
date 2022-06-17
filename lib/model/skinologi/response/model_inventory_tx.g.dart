// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_inventory_tx.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelInventoryTxCustom _$ModelInventoryTxCustomFromJson(
        Map<String, dynamic> json) =>
    ModelInventoryTxCustom(
      inventory:
          ModelInventory.fromJson(json['inventory'] as Map<String, dynamic>),
      inventoryTx: ModelInventoryTx.fromJson(
          json['inventoryTx'] as Map<String, dynamic>),
      patient: ModelPatient.fromJson(json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModelInventoryTxCustomToJson(
        ModelInventoryTxCustom instance) =>
    <String, dynamic>{
      'inventory': instance.inventory,
      'inventoryTx': instance.inventoryTx,
      'patient': instance.patient,
    };
