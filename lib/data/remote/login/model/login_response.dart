class LoginResponse {
  String status;
  String message;
  LoginData data;

  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        data: LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class LoginData {
  String a;

  LoginData({
    this.a,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        a: json["a"],
      );

  Map<String, dynamic> toJson() => {
        "a": a,
      };
}
