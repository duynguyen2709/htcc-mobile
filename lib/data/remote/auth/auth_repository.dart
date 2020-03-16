import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/auth/model/change_password_response.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/login_response.dart';

class AuthRepository extends BaseRepository {
  AuthRepository() : super();

  Future<BaseModel> login(String userName, String password, String companyId) async {
    Map<String, dynamic> map = Map();
    map.addAll({"clientId": "1", "companyId": companyId, "password": password, "username": userName});
    try {
      var response = await dio.post(DioManager.PATH_LOGIN, data: map);
      if (response.data["returnCode"] == 1 && response.data["data"] != null) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        if (loginResponse.returnCode == 1 && loginResponse.data != null) {
          var sharedPreference = await SharedPreferences.getInstance();
          sharedPreference.setString(Constants.TOKEN, loginResponse.data.token);
          sharedPreference.setString(Constants.USERNAME, loginResponse.data.user.username);
          sharedPreference.setString(Constants.COMPANY_ID, loginResponse.data.user.companyId);
          sharedPreference.setString(Constants.EMPLOYEE_ID, loginResponse.data.user.employeeId);
          sharedPreference.setString(Constants.OFFICE_ID, loginResponse.data.user.officeId);
          sharedPreference.setString(Constants.DEPARTMENT, loginResponse.data.user.department);
          sharedPreference.setString(Constants.FULL_NAME, loginResponse.data.user.fullName);
          sharedPreference.setString(Constants.BIRTH_DATE, loginResponse.data.user.birthDate);
          sharedPreference.setString(Constants.EMAIL, loginResponse.data.user.email);
          sharedPreference.setString(Constants.IDENTITY_CARD_NO, loginResponse.data.user.identityCardNo);
          sharedPreference.setString(Constants.PHONE_NUMBER, loginResponse.data.user.phoneNumber);
          sharedPreference.setString(Constants.ADDRESS, loginResponse.data.user.address);
          sharedPreference.setString(Constants.AVATAR, loginResponse.data.user.avatar);

          return SuccessModel(loginResponse, null);
        }
      }
      return ErrorModel(null, Status.LOGIN_FAIL);
    } on DioError catch (error) {
      return ErrorModel(error, Status.ERROR_NETWORK);
    }
  }

  Future<bool> logout() async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      String token = sharedPreference.getString(Constants.TOKEN);
      removeSharedPreference(sharedPreference);
      var response =
          await dio.post(DioManager.PATH_LOGOUT, options: Options(headers: {"authorization": "Bearer $token"}));

      if (response.data['returnCode'] == 1 && response.data['data'] != null) {
        return true;
      }
      return false;
    } on DioError catch (error) {
      return false;
    }
  }

  Future<BaseModel> changePassword(String userName, String newPassword, String oldPassword, String companyId) async {
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
          options: Options(headers: {"authorization": "Bearer $token", "clientId": 1}), data: map);
      ChangePasswordResponse changePasswordResponse = ChangePasswordResponse.fromJson(response.data);
      if (changePasswordResponse.returnCode == 1 && changePasswordResponse.data != null) {
        return SuccessModel(changePasswordResponse, null);
      }
      return ErrorModel(null, changePasswordResponse.returnMessage);
    } on DioError catch (error) {
      return ErrorModel(null, Status.FAIL);
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
