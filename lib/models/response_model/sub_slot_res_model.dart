// To parse this JSON data, do
//
//     final subscriptionSlotResponseModel = subscriptionSlotResponseModelFromJson(jsonString);

import 'dart:convert';

SubscriptionSlotResponseModel subscriptionSlotResponseModelFromJson(
        String str) =>
    SubscriptionSlotResponseModel.fromJson(json.decode(str));

String subscriptionSlotResponseModelToJson(
        SubscriptionSlotResponseModel data) =>
    json.encode(data.toJson());

class SubscriptionSlotResponseModel {
  SubscriptionSlotResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory SubscriptionSlotResponseModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionSlotResponseModel(
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
    this.createdAt,
    this.updatedAt,
    this.accountNumber,
    this.placeId,
    this.slotQuantity,
    this.strtDate,
    this.endDate,
    this.subscriptionAmount,
    this.paymentStatus,
    this.active,
    this.parkingType,
    this.palnDuration,
    this.subscriptionId,
    this.parkingName,
    this.autoRenewal,
    this.accessControl,
    this.stratDate,
    this.vehicleType,
    this.status,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int accountNumber;
  int placeId;
  String slotQuantity;
  DateTime strtDate;
  DateTime endDate;
  String subscriptionAmount;
  int paymentStatus;
  int active;
  String parkingType;
  dynamic palnDuration;
  int subscriptionId;
  String parkingName;
  int autoRenewal;
  List<int> accessControl;
  DateTime stratDate;
  String vehicleType;
  int status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        accountNumber: json["account_number"],
        placeId: json["place_id"],
        slotQuantity: json["slot_quantity"],
        strtDate: DateTime.parse(json["strt_date"]),
        endDate: DateTime.parse(json["end_date"]),
        subscriptionAmount: json["subscription_amount"],
        paymentStatus: json["payment_status"],
        active: json["active"],
        parkingType: json["parking_type"],
        palnDuration: json["paln_duration"],
        subscriptionId: json["subscription_id"],
        parkingName: json["parking_name"],
        autoRenewal: json["auto_renewal"],
        accessControl: List<int>.from(json["access_control"].map((x) => x)),
        stratDate: DateTime.parse(json["strat_date"]),
        vehicleType: json["vehicle_type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "account_number": accountNumber,
        "place_id": placeId,
        "slot_quantity": slotQuantity,
        "strt_date": strtDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "subscription_amount": subscriptionAmount,
        "payment_status": paymentStatus,
        "active": active,
        "parking_type": parkingType,
        "paln_duration": palnDuration,
        "subscription_id": subscriptionId,
        "parking_name": parkingName,
        "auto_renewal": autoRenewal,
        "access_control": List<dynamic>.from(accessControl.map((x) => x)),
        "strat_date": stratDate.toIso8601String(),
        "vehicle_type": vehicleType,
        "status": status,
      };
}
