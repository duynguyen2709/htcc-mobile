import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioManager {
  static final DioManager _instance = DioManager._internal();

  // ignore: non_constant_identifier_names
  static String _BASE_URL = "";
  static const PATH_LOGIN = "api/gateway/public/login";
  static const PATH_LOGOUT = "api/gateway/private/logout";
  static const PATH_CHANGE_PASSWORD = "api/gateway/private/changepassword/1";
  static const PATH_USER = "api/employee/users";
  static const PATH_CHECK_IN = "api/employee/checkin/";
  static const PATH_COMPLAINT = "api/employee/complaint";
  static const PATH_RE_COMPLAINT = "api/employee/complaint/resubmit";
  static const PATH_CONTACTS = "api/employee/contacts";
  static const PATH_CONTACTS_FILTER = "api/employee/contacts/filter";
  static const PATH_LEAVING = "/api/employee/leaving";
  static const PATH_NOTIFICATION = "/api/employee/notifications";
  static const PATH_COUNT_NOTIFICATION = '/api/employee/home/employee';
  static const PATH_NOTIFICATION_STATUS = '/api/employee/notifications/status';

  Dio dio;

  factory DioManager() {
    return _instance;
  }

  DioManager.setBaseUrl(String baseUrl) {
    _BASE_URL = baseUrl;
  }

  DioManager._internal() {
    dio = Dio(BaseOptions(baseUrl: _BASE_URL, connectTimeout: 30000, responseType: ResponseType.json, sendTimeout: 30000));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      var sharedPreference = await SharedPreferences.getInstance();
      var token = sharedPreference.getString(Constants.TOKEN);
      options.headers.addAll({"authorization": "Bearer $token"});
      return options;
    }, onResponse: (Response response) async {
      return response;
    }, onError: (DioError e) async {
      return e;
    }));

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }
}
