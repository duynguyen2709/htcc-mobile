import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/api_response.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/empty.dart';
import 'package:hethongchamcong_mobile/data/model/login_response.dart';
import 'package:hethongchamcong_mobile/data/model/screen.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:hethongchamcong_mobile/data/utils/handle_respone.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:hethongchamcong_mobile/utils/firebase_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends BaseRepository {
  AuthRepository() : super();

  Future<Result> login(String userName, String password, String companyId) async {
    var map = Map();
    map.addAll({
      "clientId": "1",
    });
    map.addAll({
      "companyId": companyId.trim(),
      "password": password,
      "username": userName.trim(),
      'tokenPush': await FireBaseNotifications.getInstance().fireBaseMessaging.getToken(),
    });
    try {
      var response = await dio.post(DioManager.PATH_LOGIN, data: map);

      if (response.data["returnCode"] == 1 && response.data != null) {
        ApiResponse<UserData> loginResponse = ApiResponse.fromJson(response.data, (json) => UserData.fromJson(json));

        var sharedPreference = await SharedPreferences.getInstance();

        sharedPreference.setString(Constants.TOKEN, loginResponse.data.token);
        sharedPreference.setString(Constants.USER, json.encode(loginResponse.data.user));
        await Injector.mainRepository.getCountNotification();

        var users = sharedPreference.getString(Constants.USERS);

        addNewUser(sharedPreference, loginResponse.data, users, password);

        return Success(msg: loginResponse.returnMessage, data: loginResponse.data);
      }
      return Error(status: Status.LOGIN_FAIL, msg: response.data['returnMessage']);
    } catch (error) {
      return Error(status: Status.ERROR_NETWORK, msg: "Vui lòng kiểm tra lại kết nối mạng.");
    }
  }

//  Future<void> getListScreen() async {
//    //Config Screens
//    var sharedPreference = await SharedPreferences.getInstance();
//    User user = User.fromJson(jsonDecode(sharedPreference.getString(Constants.USER)));
//    var screens = await dio.get(DioManager.PATH_SCREEN + '/' + user.companyId + '/' + user.username,
//        queryParameters: {'screens': '1,2,3,4,10'});
//    var tmp = ScreenResponse.fromJson(screens.data);
//    sharedPreference.setString(Constants.LIST_SCREEN, screenResponseToJson(tmp));
//    screenResponse.data = tmp.data;
//  }

  Future<Result> logout() async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();

      var response = await dio.post(DioManager.PATH_LOGOUT,
          queryParameters: {'tokenPush': await FireBaseNotifications.getInstance().fireBaseMessaging.getToken()});

      FireBaseNotifications.getInstance().shouldHandle = false;

      ApiResponse<Empty> logOutResponse = ApiResponse.fromJson(response.data, (json) => Empty.fromJson(json));
      if (logOutResponse.returnCode == 1) {
        sharedPreference.setString(Constants.TOKEN, null);

        sharedPreference.setString(Constants.IS_LOGIN, null);

        return Success(msg: logOutResponse.returnMessage, data: null);
      }
      sharedPreference.setString(Constants.TOKEN, null);

      sharedPreference.setString(Constants.IS_LOGIN, null);

      return Error(status: Status.FAIL, msg: logOutResponse.returnMessage);
    } catch (error) {
      var sharedPreference = await SharedPreferences.getInstance();

      sharedPreference.setString(Constants.TOKEN, null);

      sharedPreference.setString(Constants.IS_LOGIN, null);

      return Error(status: Status.FAIL, msg: "Vui lòng kiểm tra lại kết nối mạng.");
    }
  }

  Future<Result> changePassword(String newPassword, String oldPassword) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      User user = User.fromJson(jsonDecode(sharedPreferences.getString(Constants.USER)));

      Map<String, dynamic> map = Map();

      map.addAll({
        "clientId": "1",
        "companyId": user.companyId,
        "newPassword": newPassword,
        "oldPassword": oldPassword,
        "username": user.username
      });
      var response = await dio.put(DioManager.PATH_CHANGE_PASSWORD, data: map);
      var result = handleResponse(response, (json) => Empty.fromJson(json));
      if (result is Success) {
        updatePassword(
            sharedPreferences, User.fromJson(jsonDecode(sharedPreferences.getString(Constants.USER))), newPassword);
      }
      return result;
    } catch (error) {
      return handleError(error);
    }
  }

  Future<String> resetPass(String code, String username) async {
    try {
      Map<String, dynamic> map = Map();

      map.addAll({
        "clientId": 1,
        "companyId": code,
        "username": username,
      });
      var response = await dio.post(DioManager.PATH_RESET_PASSWORD, data: map);
      return response.data['returnMessage'];
    } catch (error) {
      return 'Kiểm tra kết nối mạng!';
    }
  }
}
