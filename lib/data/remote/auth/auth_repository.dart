import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/api_response.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/empty.dart';
import 'package:hethongchamcong_mobile/data/model/login_response.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends BaseRepository {
  AuthRepository() : super();

  Future<Result> login(
      String userName, String password, String companyId) async {
    Map<String, dynamic> map = Map();
    map.addAll({
      "clientId": "1",
      "companyId": companyId,
      "password": password,
      "username": userName
    });
    try {
      var response = await dio.post(DioManager.PATH_LOGIN, data: map);
      ApiResponse<LoginResponse> loginResponse = ApiResponse.fromJson(
          response.data, (json) => LoginResponse.fromJson(json));
      if (loginResponse.returnCode == 1) {
        var sharedPreference = await SharedPreferences.getInstance();
        sharedPreference.setString(
            Constants.TOKEN, loginResponse.data.token);
        sharedPreference.setString(
            Constants.USER, json.encode(loginResponse.data.user.toJson()));
        return Success(
            msg: loginResponse.returnMessage, data: loginResponse.data);
      }
      return Error(status: Status.FAIL, msg: loginResponse.returnMessage);
    } catch (error) {
      return Error(
          status: Status.FAIL, msg: "Vui lòng kiểm tra lại kết nối mạng.");
    }
  }

  Future<Result> logout() async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      String token = sharedPreference.getString(Constants.TOKEN);
      removeSharedPreference(sharedPreference);
      var response = await dio.post(DioManager.PATH_LOGOUT,
          options: Options(headers: {"authorization": "Bearer $token"}));

      ApiResponse<Empty> logOutResponse =
          ApiResponse.fromJson(response.data, (json) => Empty.fromJson(json));
      if (logOutResponse.returnCode == 1) {
        return Success(msg: logOutResponse.returnMessage, data: null);
      }
      return Error(status: Status.FAIL, msg: logOutResponse.returnMessage);
    } catch (error) {
      return Error(
          status: Status.FAIL, msg: "Vui lòng kiểm tra lại kết nối mạng.");
    }
  }

  Future<Result> changePassword(String userName, String newPassword,
      String oldPassword, String companyId) async {
    Map<String, dynamic> map = Map();
    map.addAll({
      "clientId": "1",
      "companyId": companyId,
      "newPassword": newPassword,
      "oldPassword": oldPassword,
      "username": userName
    });
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      String token = sharedPreference.getString(Constants.TOKEN);
      var response = await dio.put(DioManager.PATH_CHANGE_PASSWORD,
          options: Options(
              headers: {"authorization": "Bearer $token", "clientId": 1}),
          data: map);
      ApiResponse<Empty> changePasswordResponse =
          ApiResponse.fromJson(response.data, (json) => Empty.fromJson(json));
      if (changePasswordResponse.returnCode == 1) {
        return Success(msg: changePasswordResponse.returnMessage, data: null);
      }
      return Error(
          status: Status.FAIL, msg: changePasswordResponse.returnMessage);
    } catch (error) {
      return Error(
          status: Status.FAIL, msg: "Vui lòng kiểm tra lại kết nối mạng.");
    }
  }

  void removeSharedPreference(SharedPreferences sharedPreference) {
    sharedPreference.setBool(Constants.IS_LOGIN, false);
    sharedPreference.setString(Constants.TOKEN, null);
    sharedPreference.setString(Constants.USERNAME, null);
    sharedPreference.setString(Constants.COMPANY_ID, null);
    sharedPreference.setString(Constants.EMPLOYEE_ID, null);
    sharedPreference.setString(Constants.OFFICE_ID, null);
    sharedPreference.setString(Constants.DEPARTMENT, null);
    sharedPreference.setString(Constants.FULL_NAME, null);
    sharedPreference.setString(Constants.BIRTH_DATE, null);
    sharedPreference.setString(Constants.EMAIL, null);
    sharedPreference.setString(Constants.IDENTITY_CARD_NO, null);
    sharedPreference.setString(Constants.PHONE_NUMBER, null);
    sharedPreference.setString(Constants.ADDRESS, null);
    sharedPreference.setString(Constants.AVATAR, null);
  }
}
