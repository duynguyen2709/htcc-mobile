import 'dart:convert';



class ChangePasswordResponse {
  Data data;
  int returnCode;
  String returnMessage;

  ChangePasswordResponse({
    this.data,
    this.returnCode,
    this.returnMessage,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) => ChangePasswordResponse(
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