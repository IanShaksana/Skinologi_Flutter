// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_bag_detail_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelBagDetailInventory _$ModelBagDetailInventoryFromJson(
        Map<String, dynamic> json) =>
    ModelBagDetailInventory(
      bagDetail:
          ModelBagDetail.fromJson(json['bagDetail'] as Map<String, dynamic>),
      inventory:
          ModelInventory.fromJson(json['inventory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModelBagDetailInventoryToJson(
        ModelBagDetailInventory instance) =>
    <String, dynamic>{
      'bagDetail': instance.bagDetail,
      'inventory': instance.inventory,
    };
