import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';

class LoginResponse extends BaseModel {
  String token;
  User user;

  LoginResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    token = json["token"];
    user = User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}
