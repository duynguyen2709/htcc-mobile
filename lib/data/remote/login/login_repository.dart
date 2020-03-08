import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:hethongchamcong_mobile/data/remote/login/model/login_response.dart';
import 'package:hethongchamcong_mobile/data/remote/login/model/logout_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository extends BaseRepository {
  LoginRepository() : super();

  Future<BaseModel> login(String userName, String password, String companyId) async {
    Map<String, dynamic> map = Map();
    map.addAll({"clientId": "1", "companyId": companyId, "password": password, "username": userName});
    try {
      var response = await dio.post(DioManager.PATH_LOGIN, data: map);
      if (response.data["data"] != null) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        if (loginResponse.returnCode == 1 && loginResponse.data != null) {
          var sharedPreference = await SharedPreferences.getInstance();
          sharedPreference.setString(Constants.TOKEN, loginResponse.data.token);
          sharedPreference.setString(Constants.USERNAME, userName);
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
      String userName = sharedPreference.getString(Constants.USERNAME);
      String token = sharedPreference.getString(Constants.TOKEN);
      var response = await dio.post(DioManager.PATH_LOGOUT,
          queryParameters: {"username": userName},
          options: Options(headers: {"authorization": "Bearer $token", "clientId": 1}));
      LogoutResponse logoutResponse = LogoutResponse.fromJson(response.data);
      sharedPreference.setString(Constants.USERNAME, null);
      sharedPreference.setString(Constants.TOKEN, null);
      sharedPreference.setBool(Constants.IS_LOGIN, false);
      if (logoutResponse.returnCode == 1) {
        return true;
      }
      return false;
    } on DioError catch (error) {
      return false;
    }
  }
}
