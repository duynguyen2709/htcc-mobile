import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/account_response.dart';

class AccountRepository extends BaseRepository {
  static final AccountRepository _singleton = AccountRepository._internal();

  factory AccountRepository() {
    return _singleton;
  }

  AccountRepository._internal();

  Future<BaseModel> getAccount() async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      Account account = Account(
        companyId: sharedPreference.getString(Constants.COMPANY_ID),
        username: sharedPreference.getString(Constants.USERNAME),
        employeeId: sharedPreference.getString(Constants.EMPLOYEE_ID),
        officeId: sharedPreference.getString(Constants.OFFICE_ID),
        department: sharedPreference.getString(Constants.DEPARTMENT),
        fullName: sharedPreference.getString(Constants.FULL_NAME),
        birthDate: sharedPreference.getString(Constants.BIRTH_DATE),
        email: sharedPreference.getString(Constants.EMAIL),
        identityCardNo: sharedPreference.getString(Constants.IDENTITY_CARD_NO),
        phoneNumber: sharedPreference.getString(Constants.PHONE_NUMBER),
        address: sharedPreference.getString(Constants.ADDRESS),
        avatar: sharedPreference.getString(Constants.AVATAR),
      );

      return SuccessModel(account, null);
    } catch (error) {
      return ErrorModel(null, null);
    }
  }

  Future<BaseModel> refresh() async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      var token = sharedPreference.getString(Constants.TOKEN);
      var userName = sharedPreference.getString(Constants.USERNAME);
      var companyId = sharedPreference.getString(Constants.COMPANY_ID);
      String realPath = DioManager.PATH_USER + "/$companyId/$userName";
      var response = await dio.get(realPath, options: Options(headers: {"authorization": "Bearer $token"}));

      if (response.data["returnCode"] == 1 && response.data["data"] != null) {
        AccountResponse accountResponse = AccountResponse.fromJson(response.data);
        sharedPreference.setString(Constants.USERNAME, accountResponse.data.username);
        sharedPreference.setString(Constants.COMPANY_ID, accountResponse.data.companyId);
        sharedPreference.setString(Constants.EMPLOYEE_ID, accountResponse.data.employeeId);
        sharedPreference.setString(Constants.OFFICE_ID, accountResponse.data.officeId);
        sharedPreference.setString(Constants.DEPARTMENT, accountResponse.data.department);
        sharedPreference.setString(Constants.FULL_NAME, accountResponse.data.fullName);
        sharedPreference.setString(Constants.BIRTH_DATE, accountResponse.data.birthDate);
        sharedPreference.setString(Constants.EMAIL, accountResponse.data.email);
        sharedPreference.setString(Constants.IDENTITY_CARD_NO, accountResponse.data.identityCardNo);
        sharedPreference.setString(Constants.PHONE_NUMBER, accountResponse.data.phoneNumber);
        sharedPreference.setString(Constants.ADDRESS, accountResponse.data.address);
        sharedPreference.setString(Constants.AVATAR, accountResponse.data.avatar);
        return SuccessModel(accountResponse.data, null);
      }

      if (response.data["returnCode"] == 401 || response.data["returnCode"] == -8)
        return ErrorModel(null, Status.ERROR_AUTHENTICATE);

      return ErrorModel(null, Status.FAIL);
    } on DioError catch (error) {
      if (error.response.statusCode == 401 || error.response.statusCode == -8)
        return ErrorModel(null, Status.ERROR_AUTHENTICATE);
      return ErrorModel(error, Status.ERROR_NETWORK);
    }
  }

  Future<BaseModel> updateAccount(Account account) async {
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
      var userName = sharedPreference.getString(Constants.USERNAME);
      var companyId = sharedPreference.getString(Constants.COMPANY_ID);
      String realPath = DioManager.PATH_USER + "/$companyId/$userName";
      var response = await dio.put(realPath, options: Options(headers: {"authorization": "Bearer $token"}), data: map);
      if (response.data["returnCode"] == 1 && response.data["data"] != null) {
        AccountResponse accountResponse = AccountResponse.fromJson(response.data);
        sharedPreference.setString(Constants.USERNAME, accountResponse.data.username);
        sharedPreference.setString(Constants.COMPANY_ID, accountResponse.data.companyId);
        sharedPreference.setString(Constants.EMPLOYEE_ID, accountResponse.data.employeeId);
        sharedPreference.setString(Constants.OFFICE_ID, accountResponse.data.officeId);
        sharedPreference.setString(Constants.DEPARTMENT, accountResponse.data.department);
        sharedPreference.setString(Constants.FULL_NAME, accountResponse.data.fullName);
        sharedPreference.setString(Constants.BIRTH_DATE, accountResponse.data.birthDate);
        sharedPreference.setString(Constants.EMAIL, accountResponse.data.email);
        sharedPreference.setString(Constants.IDENTITY_CARD_NO, accountResponse.data.identityCardNo);
        sharedPreference.setString(Constants.PHONE_NUMBER, accountResponse.data.phoneNumber);
        sharedPreference.setString(Constants.ADDRESS, accountResponse.data.address);
        sharedPreference.setString(Constants.AVATAR, accountResponse.data.avatar);
        return SuccessModel(accountResponse.data, null);
      }
      if (response.data["returnCode"] == 401 || response.data["returnCode"] == -8)
        return ErrorModel(null, Status.ERROR_AUTHENTICATE);
      return ErrorModel(null, Status.FAIL);
    } on DioError catch (error) {
      if (error.response.statusCode == 401 || error.response.statusCode == -8)
        return ErrorModel(null, Status.ERROR_AUTHENTICATE);
      return ErrorModel(error, Status.ERROR_NETWORK);
    }
  }
}
