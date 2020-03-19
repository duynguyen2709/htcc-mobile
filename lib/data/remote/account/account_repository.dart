import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/api_response.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.dart';

class AccountRepository extends BaseRepository {
  static final AccountRepository _singleton = AccountRepository._internal();

  factory AccountRepository() {
    return _singleton;
  }

  AccountRepository._internal();

  Future<Result> getAccount() async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      User account = User.fromJson(
          json.decode(sharedPreference.getString(Constants.USER)));
      return Success(msg: "", data: account);
    } catch (error) {
      return Error(
          msg: "Đã xảy ra lỗi trong quá trình thực hiện", status: Status.FAIL);
    }
  }

  Future<Result> refresh() async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      var token = sharedPreference.getString(Constants.TOKEN);
      User account = User.fromJson(
          json.decode(sharedPreference.getString(Constants.USER)));
      String realPath =
          DioManager.PATH_USER + "/${account.companyId}/${account.username}";
      var response = await dio.get(realPath,
          options: Options(headers: {"authorization": "Bearer $token"}));
      ApiResponse<User> getUserResponse =
          ApiResponse.fromJson(response.data, (json) => User.fromJson(json));
      if (getUserResponse.returnCode == 1) {
        var sharedPreference = await SharedPreferences.getInstance();
        sharedPreference.setString(
            Constants.USER, json.encode(getUserResponse.data.toJson()));
        return Success(
            msg: getUserResponse.returnMessage, data: getUserResponse.data);
      }

      if (response.data["returnCode"] == 401 ||
          response.data["returnCode"] == -8)
        return Error(status: Status.ERROR_AUTHENTICATE);

      return Error(status: Status.FAIL, msg: getUserResponse.returnMessage);
    } on DioError catch (error) {
      if (error.response.statusCode == 401 || error.response.statusCode == -8)
        return Error(status: Status.ERROR_AUTHENTICATE);
      return Error(status: Status.ERROR_NETWORK);
    }
  }

  Future<Result> updateAccount(User account) async {
    try {
      Map<String, dynamic> map = Map();
      map.addAll({
        "address": account.address,
        "avatar": account.avatar,
        "birthDate": account.birthDate,
        "companyId": account.companyId,
        "department": account.department,
        "email": account.email,
        "employeeId": account.employeeId,
        "fullName": account.fullName,
        "identityCardNo": account.identityCardNo,
        "officeId": account.officeId,
        "phoneNumber": account.phoneNumber,
        "username": account.username
      });
      var sharedPreference = await SharedPreferences.getInstance();
      var token = sharedPreference.getString(Constants.TOKEN);
      String realPath =
          DioManager.PATH_USER + "/${account.companyId}/${account.username}";
      var response = await dio.put(realPath,
          options: Options(headers: {"authorization": "Bearer $token"}),
          data: map);
      ApiResponse<User> getUserResponse =
          ApiResponse.fromJson(response.data, (json) => User.fromJson(json));
      if (getUserResponse.returnCode == 1) {
        var sharedPreference = await SharedPreferences.getInstance();
        sharedPreference.setString(
            Constants.USER, json.encode(getUserResponse.data.toJson()));
        return Success(
            data: getUserResponse.data, msg: getUserResponse.returnMessage);
      }
      if (response.data["returnCode"] == 401 ||
          response.data["returnCode"] == -8)
        return Error(status: Status.ERROR_AUTHENTICATE);

      return Error(status: Status.FAIL, msg: getUserResponse.returnMessage);
    } on DioError catch (error) {
      if (error.response.statusCode == 401 || error.response.statusCode == -8)
        return Error(status: Status.ERROR_AUTHENTICATE);
      return Error(status: Status.ERROR_NETWORK);
    }
  }
}
