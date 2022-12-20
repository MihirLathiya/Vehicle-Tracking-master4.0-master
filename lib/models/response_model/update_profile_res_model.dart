// To parse this JSON data, do
//
//     final updateProfileResponseModel = updateProfileResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponseModel updateProfileResponseModelFromJson(String str) =>
    UpdateProfileResponseModel.fromJson(json.decode(str));

String updateProfileResponseModelToJson(UpdateProfileResponseModel data) =>
    json.encode(data.toJson());

class UpdateProfileResponseModel {
  UpdateProfileResponseModel({
    this.status,
    this.message,
    this.user,
  });

  bool status;
  String message;
  User user;

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseModel(
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
    this.image,
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
  String trn;
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
  String image;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        image: json["image"],
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
        "image": image,
      };
}
