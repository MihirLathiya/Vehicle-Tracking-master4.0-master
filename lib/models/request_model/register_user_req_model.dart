class RegisterUserRequestModel {
  String firstName;
  String lastName;
  String companyName;
  String companyAddress;
  String mobileNumber;
  String whatappNumber;
  String email;
  RegisterUserRequestModel(
      {this.firstName,
      this.lastName,
      this.companyName,
      this.companyAddress,
      this.mobileNumber,
      this.whatappNumber,
      this.email});

  RegisterUserRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    mobileNumber = json['mobile_number'];
    whatappNumber = json['whatapp_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['mobile_number'] = this.mobileNumber;
    data['whatapp_number'] = this.whatappNumber;
    data['email'] = this.email;
    return data;
  }
}
