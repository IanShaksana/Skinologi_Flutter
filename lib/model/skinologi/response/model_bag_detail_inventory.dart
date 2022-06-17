import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_bag.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
part 'model_bag_detail_inventory.g.dart';

@JsonSerializable()
class ModelBagDetailInventory {

  ModelBagDetail bagDetail;
  ModelInventory inventory;

  ModelBagDetailInventory({
    required this.bagDetail,
    required this.inventory,
  });

  factory ModelBagDetailInventory.fromJson(Map<String, dynamic> value) {
    return _$ModelBagDetailInventoryFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelBagDetailInventoryToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}