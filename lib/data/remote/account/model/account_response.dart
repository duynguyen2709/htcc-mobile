import 'dart:convert';

AccountResponse accountResponseFromJson(String str) => AccountResponse.fromJson(json.decode(str));

String accountResponseToJson(AccountResponse data) => json.encode(data.toJson());

class AccountResponse {
  int returnCode;
  String returnMessage;
  Account data;

  AccountResponse({
    this.returnCode,
    this.returnMessage,
    this.data,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) => AccountResponse(
        returnCode: json["returnCode"],
        returnMessage: json["returnMessage"],
        data: Account.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "returnMessage": returnMessage,
        "data": data.toJson(),
      };
}

class Account {
  String companyId;
  String username;
  String employeeId;
  String officeId;
  String department;
  String fullName;
  String birthDate;
  String email;
  String identityCardNo;
  String phoneNumber;
  String address;
  String avatar;

  Account({
    this.companyId,
    this.username,
    this.employeeId,
    this.officeId,
    this.department,
    this.fullName,
    this.birthDate,
    this.email,
    this.identityCardNo,
    this.phoneNumber,
    this.address,
    this.avatar,
  });

  Account.empty() {
    companyId = "";
    username = "";
    employeeId = "";
    officeId = "";
    department = "";
    fullName = "";
    birthDate = "";
    email = "";
    identityCardNo = "";
    phoneNumber = "";
    address = "";
    avatar = "assets/human_error.png";
  }

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        companyId: json["companyId"],
        username: json["username"],
        employeeId: json["employeeId"],
        officeId: json["officeId"],
        department: json["department"],
        fullName: json["fullName"],
        birthDate: json["birthDate"],
        email: json["email"],
        identityCardNo: json["identityCardNo"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "username": username,
        "employeeId": employeeId,
        "officeId": officeId,
        "department": department,
        "fullName": fullName,
        "birthDate": birthDate,
        "email": email,
        "identityCardNo": identityCardNo,
        "phoneNumber": phoneNumber,
        "address": address,
        "avatar": avatar,
      };
}
