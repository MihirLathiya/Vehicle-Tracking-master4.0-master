// To parse this JSON data, do
//
//     final getSubscriptionResponseModel = getSubscriptionResponseModelFromJson(jsonString);

import 'dart:convert';

GetSubscriptionResponseModel getSubscriptionResponseModelFromJson(String str) =>
    GetSubscriptionResponseModel.fromJson(json.decode(str));

String getSubscriptionResponseModelToJson(GetSubscriptionResponseModel data) =>
    json.encode(data.toJson());

class GetSubscriptionResponseModel {
  GetSubscriptionResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory GetSubscriptionResponseModel.fromJson(Map<String, dynamic> json) =>
      GetSubscriptionResponseModel(
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
    this.placeId,
    this.slotQuantity,
    this.strtDate,
    this.endDate,
    this.subscriptionAmount,
    this.parkingType,
    this.parkingLocation,
    this.vehicleType,
  });

  int id;
  int placeId;
  String slotQuantity;
  DateTime strtDate;
  DateTime endDate;
  String subscriptionAmount;
  String parkingType;
  String parkingLocation;
  String vehicleType;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        placeId: json["place_id"],
        slotQuantity: json["slot_quantity"],
        strtDate: DateTime.parse(json["strt_date"]),
        endDate: DateTime.parse(json["end_date"]),
        subscriptionAmount: json["subscription_amount"],
        parkingType: json["parking_type"],
        parkingLocation: json["parking_location"],
        vehicleType: json["vehicle_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_id": placeId,
        "slot_quantity": slotQuantity,
        "strt_date": strtDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "subscription_amount": subscriptionAmount,
        "parking_type": parkingType,
        "parking_location": parkingLocation,
        "vehicle_type": vehicleType,
      };
}
