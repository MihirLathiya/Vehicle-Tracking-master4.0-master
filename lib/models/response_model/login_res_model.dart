// To parse this JSON data, do
//
//     final logInResponseModel = logInResponseModelFromJson(jsonString);

import 'dart:convert';

LogInResponseModel logInResponseModelFromJson(String str) =>
    LogInResponseModel.fromJson(json.decode(str));

String logInResponseModelToJson(LogInResponseModel data) =>
    json.encode(data.toJson());

class LogInResponseModel {
  LogInResponseModel({
    this.success,
    this.userDetail,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.message,
  });

  bool success;
  UserDetail userDetail;
  String accessToken;
  String tokenType;
  int expiresIn;
  String message;

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) =>
      LogInResponseModel(
        success: json["success"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user_detail": userDetail.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "message": message,
      };
}

class UserDetail {
  UserDetail({
    this.id,
    this.firstName,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.lastName,
    this.companyName,
    this.companyAddress,
    this.mobileNumber,
    this.whatappNumber,
    this.trn,
    this.accountNumber,
    this.employeeId,
    this.role,
    this.fullName,
    this.nationality,
    this.gender,
    this.dob,
    this.status,
    this.addressUae,
    this.homeCountryAddress,
    this.countryId,
    this.homeCountryContactPerson,
    this.height,
    this.weight,
    this.genotype,
    this.bloodGroup,
    this.allergyAilment,
  });

  int id;
  String firstName;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String lastName;
  String companyName;
  String companyAddress;
  String mobileNumber;
  String whatappNumber;
  dynamic trn;
  String accountNumber;
  dynamic employeeId;
  String role;
  dynamic fullName;
  dynamic nationality;
  dynamic gender;
  dynamic dob;
  dynamic status;
  dynamic addressUae;
  dynamic homeCountryAddress;
  dynamic countryId;
  dynamic homeCountryContactPerson;
  dynamic height;
  dynamic weight;
  dynamic genotype;
  dynamic bloodGroup;
  dynamic allergyAilment;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        firstName: json["first_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        lastName: json["last_name"],
        companyName: json["company_name"],
        companyAddress: json["company_address"],
        mobileNumber: json["mobile_number"],
        whatappNumber: json["whatapp_number"],
        trn: json["TRN"],
        accountNumber: json["account_number"],
        employeeId: json["employee_id"],
        role: json["role"],
        fullName: json["full_name"],
        nationality: json["nationality"],
        gender: json["gender"],
        dob: json["DOB"],
        status: json["status"],
        addressUae: json["address_UAE"],
        homeCountryAddress: json["home_country_address"],
        countryId: json["country_id"],
        homeCountryContactPerson: json["home_country_contact_person"],
        height: json["height"],
        weight: json["weight"],
        genotype: json["genotype"],
        bloodGroup: json["bloodGroup"],
        allergyAilment: json["allergy_ailment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "last_name": lastName,
        "company_name": companyName,
        "company_address": companyAddress,
        "mobile_number": mobileNumber,
        "whatapp_number": whatappNumber,
        "TRN": trn,
        "account_number": accountNumber,
        "employee_id": employeeId,
        "role": role,
        "full_name": fullName,
        "nationality": nationality,
        "gender": gender,
        "DOB": dob,
        "status": status,
        "address_UAE": addressUae,
        "home_country_address": homeCountryAddress,
        "country_id": countryId,
        "home_country_contact_person": homeCountryContactPerson,
        "height": height,
        "weight": weight,
        "genotype": genotype,
        "bloodGroup": bloodGroup,
        "allergy_ailment": allergyAilment,
      };
}
