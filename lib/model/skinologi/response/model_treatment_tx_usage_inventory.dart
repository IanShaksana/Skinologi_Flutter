import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_treatment.dart';
part 'model_treatment_tx_usage_inventory.g.dart';

@JsonSerializable()
class ModelTreatmentTxUsageInventory {
  ModelTreatmentTx? treatmentTx;
  ModelPatient? patient;
  ModelTreatmentUsage? treatmentUsage;
  ModelInventory? inventory;

  ModelTreatmentTxUsageInventory({
    this.treatmentTx,
    this.patient,
    this.treatmentUsage,
    this.inventory,
  });

  factory ModelTreatmentTxUsageInventory.fromJson(Map<String, dynamic> value) {
    return _$ModelTreatmentTxUsageInventoryFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelTreatmentTxUsageInventoryToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}
