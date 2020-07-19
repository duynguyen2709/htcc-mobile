import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/api_response.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';

Result handleResponse<T extends BaseModel>(Response response,
    T Function(Map<String, dynamic>) func) {
  try {
    if (response.data["returnCode"] == 401 || response.data["returnCode"] == -8)
      return Error(status: Status.ERROR_AUTHENTICATE);
    if (response.data["returnCode"] == 1) {
      ApiResponse<T> res = ApiResponse.fromJson(response.data, func);
      return Success(data: res.data, msg: res.returnMessage);
    } else {
      return Error(status: Status.FAIL, msg: response.data["returnMessage"]);
    }
  } catch (error) {
    if (response.data["returnCode"] == 401 || response.data["returnCode"] == -8)
      return Error(status: Status.ERROR_AUTHENTICATE);
    return Error(
        status: Status.FAIL, msg: "Vui lòng kiểm tra lại kết nối mạng.");
  }
}

Result handleListResponse<T extends BaseModel>(Response response,
    T Function(Map<String, dynamic>) func) {
  try {
    if (response.data["returnCode"] == 401 || response.data["returnCode"] == -8)
      return Error(status: Status.ERROR_AUTHENTICATE);

    if (response.data["returnCode"] == 1) {
      var res = ListApiResponse<T>.fromJson(response.data, func);
      return Success(data: res.data, msg: res.returnMessage);
    } else {
      return Error(status: Status.FAIL, msg: response.data["returnMessage"]);
    }
  } catch (error) {
    if (response.data["returnCode"] == 401 || response.data["returnCode"] == -8)
      return Error(status: Status.ERROR_AUTHENTICATE);
    return Error(
        status: Status.FAIL, msg: "Vui lòng kiểm tra lại kết nối mạng.");
  }
}

Result handleError(var error) {
  try {
    if (error.response.statusCode == 401) {
      return Error(status: Status.ERROR_AUTHENTICATE);
    } else {
      return Error(
          status: Status.FAIL, msg: "Đã xảy ra lỗi trong quá trình xử lý.");
    }
  }
  catch(e){
    return Error(
        status: Status.FAIL, msg: "Đã xảy ra lỗi trong quá trình xử lý.");
  }
}
