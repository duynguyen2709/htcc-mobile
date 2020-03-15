import 'package:dio/dio.dart';

class DioManager {
  static final DioManager _instance = DioManager._internal();
  static const BASE_URL = "https://1612145.online/";
  static const PATH_LOGIN = "api/gateway/public/login";
  static const PATH_LOGOUT = "/api/gateway/private/logout/1";
  static const PATH_CHANGE_PASSWORD = "api/gateway/private/changepassword/1";

  Dio dio;

  factory DioManager() {
    return _instance;
  }

  DioManager._internal() {
    dio = Dio(BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: 10000,
        responseType: ResponseType.json,
        sendTimeout: 10000));
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}
