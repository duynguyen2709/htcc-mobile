import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<UserData> userDataFromJson(String str) => List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

addNewUser(SharedPreferences sharedPreferences, UserData userData, String users, String password) {
  List<UserData> list = List();

  if (users == null || users.isEmpty) {
    list.insert(0, UserData(token: userData.token, user: userData.user, password: password));
  } else {
    list = userDataFromJson(users);
    list = list.where((UserData value) => value.user.employeeId != userData.user.employeeId).toList();
    list.insert(0, UserData(token: userData.token, user: userData.user, password: password));
  }

  sharedPreferences.setString(Constants.USERS, userDataToJson(list));
}

updateUserData(SharedPreferences sharedPreferences, User user) {
  String usersJson = sharedPreferences.getString(Constants.USERS);
  List<UserData> users = userDataFromJson(usersJson);
  UserData userData = users.lastWhere((value) => value.user.employeeId == user.employeeId);
  userData.user = user;
  sharedPreferences.setString(Constants.USERS, userDataToJson(users));
}

updatePassword(SharedPreferences sharedPreferences, User user, String newPassword) {
  String usersJson = sharedPreferences.getString(Constants.USERS);
  List<UserData> users = userDataFromJson(usersJson);
  UserData userData = users.lastWhere((value) => value.user.employeeId == user.employeeId);
  userData.password = newPassword;
  sharedPreferences.setString(Constants.USERS, userDataToJson(users));
}

class UserData extends BaseModel {
  UserData({this.token, this.user, this.password});

  String token;
  String password;
  User user;

  UserData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    token = json["token"];
    password = json["password"];
    user = User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "password": password,
        "user": user.toJson(),
      };
}
