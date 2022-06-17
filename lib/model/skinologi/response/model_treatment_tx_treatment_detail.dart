import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_treatment.dart';
part 'model_treatment_tx_treatment_detail.g.dart';

@JsonSerializable()
class ModelTreatmentTxTreatmentDetail {
  ModelTreatmentTx? treatmentTx;
  ModelPatient? patient;
  List<ModelTreatment>? treatment;
  List<ModelTreatmentDetail>? treatmentDetail;
  List<ModelTreatmentUsage>? treatmentUsage;
  List<ModelInventoryTx>? inventoryTx;

  ModelTreatmentTxTreatmentDetail({
    this.treatmentTx,
    this.patient,
    this.treatment,
    this.treatmentDetail,
    this.treatmentUsage,
    this.inventoryTx,
  });

  factory ModelTreatmentTxTreatmentDetail.fromJson(Map<String, dynamic> value) {
    return _$ModelTreatmentTxTreatmentDetailFromJson(value);
  }

  String toJson() {
    var usermap = _$ModelTreatmentTxTreatmentDetailToJson(this);
    var data = jsonEncode(usermap);
    return data;
  }
}
