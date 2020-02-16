class AccountResponse {
  String status;
  String message;
  AccountData data;

  AccountResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      AccountResponse(
        status: json["status"],
        message: json["message"],
        data: AccountData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class AccountData {
  String linkAvatar;
  String name;
  String phone;
  String gender;
  String age;
  String city;

  AccountData({
    this.linkAvatar,
    this.name,
    this.phone,
    this.gender,
    this.age,
    this.city,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) => AccountData(
        linkAvatar: json["linkAvatar"],
        name: json["name"],
        phone: json["phone"],
        gender: json["gender"],
        age: json["age"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "linkAvatar": linkAvatar,
        "name": name,
        "phone": phone,
        "gender": gender,
        "age": age,
        "city": city,
      };
}
