import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
part 'model_inventory_tx.g.dart';

@JsonSerializable()
class ModelInventoryTxCustom {
  ModelInventory inventory;
  ModelInventoryTx inventoryTx;
  ModelPatient patient;

  ModelInventoryTxCustom({
    required this.inventory,
    required this.inventoryTx,
    required this.patient,
  });

  factory ModelInventoryTxCustom.fromJson(Map<String, dynamic> value) {
    return _$ModelInventoryTxCustomFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelInventoryTxCustomToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}
