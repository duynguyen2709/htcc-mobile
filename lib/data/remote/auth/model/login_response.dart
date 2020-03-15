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

  Data({
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
