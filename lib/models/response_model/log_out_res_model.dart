// To parse this JSON data, do
//
//     final logOutResponseModel = logOutResponseModelFromJson(jsonString);

import 'dart:convert';

LogOutResponseModel logOutResponseModelFromJson(String str) =>
    LogOutResponseModel.fromJson(json.decode(str));

String logOutResponseModelToJson(LogOutResponseModel data) =>
    json.encode(data.toJson());

class LogOutResponseModel {
  LogOutResponseModel({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory LogOutResponseModel.fromJson(Map<String, dynamic> json) =>
      LogOutResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
