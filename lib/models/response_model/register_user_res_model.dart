// To parse this JSON data, do
//
//     final registerUserResponseModel = registerUserResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterUserResponseModel registerUserResponseModelFromJson(String str) =>
    RegisterUserResponseModel.fromJson(json.decode(str));

String registerUserResponseModelToJson(RegisterUserResponseModel data) =>
    json.encode(data.toJson());

class RegisterUserResponseModel {
  RegisterUserResponseModel({
    this.status,
    this.message,
    this.user,
  });

  bool status;
  String message;
  User user;

  factory RegisterUserResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserResponseModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.companyName,
    this.companyAddress,
    this.mobileNumber,
    this.whatappNumber,
    this.trn,
    this.accountNumber,
    this.email,
    this.role,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String firstName;
  String lastName;
  String companyName;
  String companyAddress;
  String mobileNumber;
  String whatappNumber;
  dynamic trn;
  int accountNumber;
  String email;
  String role;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        companyName: json["company_name"],
        companyAddress: json["company_address"],
        mobileNumber: json["mobile_number"],
        whatappNumber: json["whatapp_number"],
        trn: json["TRN"],
        accountNumber: json["account_number"],
        email: json["email"],
        role: json["role"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company_name": companyName,
        "company_address": companyAddress,
        "mobile_number": mobileNumber,
        "whatapp_number": whatappNumber,
        "TRN": trn,
        "account_number": accountNumber,
        "email": email,
        "role": role,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
