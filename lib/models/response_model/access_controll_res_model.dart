// To parse this JSON data, do
//
//     final accessControlResponseModel = accessControlResponseModelFromJson(jsonString);

import 'dart:convert';

AccessControlResponseModel accessControlResponseModelFromJson(String str) =>
    AccessControlResponseModel.fromJson(json.decode(str));

String accessControlResponseModelToJson(AccessControlResponseModel data) =>
    json.encode(data.toJson());

class AccessControlResponseModel {
  AccessControlResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory AccessControlResponseModel.fromJson(Map<String, dynamic> json) =>
      AccessControlResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.plaseId,
    this.controlsId,
    this.controlsPrize,
    this.createdAt,
    this.updatedAt,
    this.depositAmount,
    this.refundAmount,
    this.controlName,
    this.prize,
  });

  int id;
  int plaseId;
  int controlsId;
  String controlsPrize;
  DateTime createdAt;
  DateTime updatedAt;
  int depositAmount;
  int refundAmount;
  String controlName;
  int prize;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        plaseId: json["plase_id"],
        controlsId: json["controls_id"],
        controlsPrize: json["controls_prize"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        depositAmount: json["deposit_amount"],
        refundAmount: json["refund_amount"],
        controlName: json["control_name"],
        prize: json["prize"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plase_id": plaseId,
        "controls_id": controlsId,
        "controls_prize": controlsPrize,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deposit_amount": depositAmount,
        "refund_amount": refundAmount,
        "control_name": controlName,
        "prize": prize,
      };
}
