// To parse this JSON data, do
//
//     final getParkingSlotResponseModel = getParkingSlotResponseModelFromJson(jsonString);

import 'dart:convert';

GetParkingSlotResponseModel getParkingSlotResponseModelFromJson(String str) =>
    GetParkingSlotResponseModel.fromJson(json.decode(str));

String getParkingSlotResponseModelToJson(GetParkingSlotResponseModel data) =>
    json.encode(data.toJson());

class GetParkingSlotResponseModel {
  GetParkingSlotResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetParkingSlotResponseModel.fromJson(Map<String, dynamic> json) =>
      GetParkingSlotResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.image,
    this.description,
    this.subscription,
    this.twoWheeler,
    this.fourWheeler,
  });

  String image;
  String description;
  int subscription;
  int twoWheeler;
  int fourWheeler;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        image: json["image"],
        description: json["description"],
        subscription: json["subscription"],
        twoWheeler: json["two_wheeler"],
        fourWheeler: json["four_wheeler"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "description": description,
        "subscription": subscription,
        "two_wheeler": twoWheeler,
        "four_wheeler": fourWheeler,
      };
}
