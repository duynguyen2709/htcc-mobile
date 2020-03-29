import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/api_response.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/login_response.dart';
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
      User account = User.fromJson(json.decode(sharedPreference.getString(Constants.USER)));
      return Success(msg: "", data: account);
    } catch (error) {
      return Error(msg: "Đã xảy ra lỗi trong quá trình thực hiện", status: Status.FAIL);
    }
  }

  Future<Result> refresh() async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      User account = User.fromJson(json.decode(sharedPreference.getString(Constants.USER)));
      String realPath = DioManager.PATH_USER + "/${account.companyId}/${account.username}";
      var response = await dio.get(realPath);
      ApiResponse<User> getUserResponse = ApiResponse.fromJson(response.data, (json) => User.fromJson(json));
      if (getUserResponse.returnCode == 1) {
        var sharedPreference = await SharedPreferences.getInstance();
        sharedPreference.setString(Constants.USER, json.encode(getUserResponse.data.toJson()));
        await updateUserData(sharedPreference, account);
        return Success(msg: getUserResponse.returnMessage, data: getUserResponse.data);
      }

      if (response.data["returnCode"] == 401 || response.data["returnCode"] == -8)
        return Error(status: Status.ERROR_AUTHENTICATE);

      return Error(status: Status.FAIL, msg: getUserResponse.returnMessage);
    } on DioError catch (error) {
      if (error.response.statusCode == 401 || error.response.statusCode == -8)
        return Error(status: Status.ERROR_AUTHENTICATE);
      return Error(status: Status.ERROR_NETWORK);
    }
  }

  Future<Result> updateAccount(User account, File image) async {
    try {
      FormData map = FormData.fromMap({
        "address": account.address,
        "avatar":
        (image != null) ? await MultipartFile.fromFile(image.path, filename: image.path.split('/').last) : "",
        "birthDate": account.birthDate,
        "companyId": account.companyId,
        "department": account.department,
        "email": account.email,
        "employeeId": account.employeeId,
        "fullName": account.fullName,
        "identityCardNo": account.identityCardNo,
        "officeId": account.officeId,
        "title": account.title,
        "phoneNumber": account.phoneNumber,
        "username": account.username
      });

      String realPath = DioManager.PATH_USER + "/${account.companyId}/${account.username}";

      var response = await dio.post(realPath, data: map);

      ApiResponse<User> getUserResponse = ApiResponse.fromJson(response.data, (json) => User.fromJson(json));
      if (getUserResponse.returnCode == 1) {
        var sharedPreference = await SharedPreferences.getInstance();
        sharedPreference.setString(Constants.USER, json.encode(getUserResponse.data.toJson()));
        await updateUserData(sharedPreference, getUserResponse.data);
        return Success(data: getUserResponse.data, msg: getUserResponse.returnMessage);
      }
      if (response.data["returnCode"] == 401 || response.data["returnCode"] == -8)
        return Error(status: Status.ERROR_AUTHENTICATE);

      return Error(status: Status.FAIL, msg: getUserResponse.returnMessage);
    } on DioError catch (error) {
      if (error.response.statusCode == 401 || error.response.statusCode == -8)
        return Error(status: Status.ERROR_AUTHENTICATE);
      return Error(status: Status.ERROR_NETWORK);
    }
  }
}
