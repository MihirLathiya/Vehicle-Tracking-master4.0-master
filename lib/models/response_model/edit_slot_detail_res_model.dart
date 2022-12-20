// To parse this JSON data, do
//
//     final editSlotDetailsResponseModel = editSlotDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

EditSlotDetailsResponseModel editSlotDetailsResponseModelFromJson(String str) =>
    EditSlotDetailsResponseModel.fromJson(json.decode(str));

String editSlotDetailsResponseModelToJson(EditSlotDetailsResponseModel data) =>
    json.encode(data.toJson());

class EditSlotDetailsResponseModel {
  EditSlotDetailsResponseModel({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory EditSlotDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      EditSlotDetailsResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
