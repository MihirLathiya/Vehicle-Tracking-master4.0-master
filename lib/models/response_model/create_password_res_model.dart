// To parse this JSON data, do
//
//     final createPasswordResponseModel = createPasswordResponseModelFromJson(jsonString);

import 'dart:convert';

CreatePasswordResponseModel createPasswordResponseModelFromJson(String str) =>
    CreatePasswordResponseModel.fromJson(json.decode(str));

String createPasswordResponseModelToJson(CreatePasswordResponseModel data) =>
    json.encode(data.toJson());

class CreatePasswordResponseModel {
  CreatePasswordResponseModel({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory CreatePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      CreatePasswordResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
