// To parse this JSON data, do
//
//     final cancleSubscriptionResponseModel = cancleSubscriptionResponseModelFromJson(jsonString);

import 'dart:convert';

CancleSubscriptionResponseModel cancleSubscriptionResponseModelFromJson(
        String str) =>
    CancleSubscriptionResponseModel.fromJson(json.decode(str));

String cancleSubscriptionResponseModelToJson(
        CancleSubscriptionResponseModel data) =>
    json.encode(data.toJson());

class CancleSubscriptionResponseModel {
  CancleSubscriptionResponseModel({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory CancleSubscriptionResponseModel.fromJson(Map<String, dynamic> json) =>
      CancleSubscriptionResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
