// To parse this JSON data, do
//
//     final subscriptionDetailsResponseModel = subscriptionDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

SubscriptionDetailsResponseModel subscriptionDetailsResponseModelFromJson(
        String str) =>
    SubscriptionDetailsResponseModel.fromJson(json.decode(str));

String subscriptionDetailsResponseModelToJson(
        SubscriptionDetailsResponseModel data) =>
    json.encode(data.toJson());

class SubscriptionDetailsResponseModel {
  SubscriptionDetailsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory SubscriptionDetailsResponseModel.fromJson(
          Map<String, dynamic> json) =>
      SubscriptionDetailsResponseModel(
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
    this.parkingNumber,
  });

  int id;
  int placeId;
  String slotQuantity;
  dynamic strtDate;
  dynamic endDate;
  String subscriptionAmount;
  dynamic parkingNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        placeId: json["place_id"],
        slotQuantity: json["slot_quantity"],
        strtDate: json["strt_date"],
        endDate: json["end_date"],
        subscriptionAmount: json["subscription_amount"],
        parkingNumber: json["parking_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "place_id": placeId,
        "slot_quantity": slotQuantity,
        "strt_date": strtDate,
        "end_date": endDate,
        "subscription_amount": subscriptionAmount,
        "parking_number": parkingNumber,
      };
}
