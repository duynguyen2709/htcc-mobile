import 'package:dio/dio.dart';

class DioManager {
  static final DioManager _instance = DioManager._internal();
  static const BASE_URL = "http://beautiful-me-app.posapp.vn/api/";

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
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
