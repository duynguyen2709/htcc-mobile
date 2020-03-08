// To parse this JSON data, do
//
//     final logoutResponse = logoutResponseFromJson(jsonString);

import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) => LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  Data data;
  int returnCode;
  String returnMessage;

  LogoutResponse({
    this.data,
    this.returnCode,
    this.returnMessage,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
    data: Data.fromJson(json["data"]),
    returnCode: json["returnCode"],
    returnMessage: json["returnMessage"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "returnCode": returnCode,
    "returnMessage": returnMessage,
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}