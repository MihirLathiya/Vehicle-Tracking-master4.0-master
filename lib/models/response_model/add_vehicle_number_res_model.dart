// To parse this JSON data, do
//
//     final storeVehicleNumberResponseModel = storeVehicleNumberResponseModelFromJson(jsonString);

import 'dart:convert';

StoreVehicleNumberResponseModel storeVehicleNumberResponseModelFromJson(
        String str) =>
    StoreVehicleNumberResponseModel.fromJson(json.decode(str));

String storeVehicleNumberResponseModelToJson(
        StoreVehicleNumberResponseModel data) =>
    json.encode(data.toJson());

class StoreVehicleNumberResponseModel {
  StoreVehicleNumberResponseModel({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory StoreVehicleNumberResponseModel.fromJson(Map<String, dynamic> json) =>
      StoreVehicleNumberResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
