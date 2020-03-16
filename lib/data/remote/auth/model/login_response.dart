// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int returnCode;
  String returnMessage;
  Data data;

  LoginResponse({
    this.returnCode,
    this.returnMessage,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        returnCode: json["returnCode"],
        returnMessage: json["returnMessage"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "returnMessage": returnMessage,
        "data": data.toJson(),
      };
}

class Data {
  String token;
  User user;

  Data({
    this.token,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
