import 'package:dio/dio.dart';

class DioManager {
  static final DioManager _instance = DioManager._internal();
  // ignore: non_constant_identifier_names
  static String _BASE_URL = "";
  static const PATH_LOGIN = "api/gateway/public/login";
  static const PATH_LOGOUT = "api/gateway/private/logout";
  static const PATH_CHANGE_PASSWORD = "api/gateway/private/changepassword/1";
  static const PATH_USER = "api/employee/users";
  static const PATH_CHECK_IN = "/api/employee/checkin/";


  Dio dio;

  factory DioManager() {
    return _instance;
  }
  DioManager.setBaseUrl(String baseUrl){
      _BASE_URL = baseUrl;
  }

  DioManager._internal() {
    dio = Dio(BaseOptions(
        baseUrl: _BASE_URL,
        connectTimeout: 90000,
        responseType: ResponseType.json,
        sendTimeout: 90000));
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}
