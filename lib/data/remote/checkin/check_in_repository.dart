import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/api_response.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_info.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/data/model/empty.dart';
import 'package:hethongchamcong_mobile/data/utils/handle_respone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dio.dart';

class CheckInRepository extends BaseRepository {
  CheckInRepository() : super();

  Future<Result> getCheckInInfo({String companyId, String username, String date}) async {
    try {
      String datePath = date != null ? '?date=$date' : '';
      String url = '${DioManager.PATH_CHECK_IN}/$companyId/$username' + '$datePath';
      var response = await dio.get(url);
      var result = handleResponse<CheckInInfo>(response, (json) => CheckInInfo.fromJson(json));
      return result;
    } catch (error) {
      return handleError(error);
    }
  }

  Future<Result> checkIn(CheckInParam param) async {
    try {
      String url = '${DioManager.PATH_CHECK_IN}/location';
      var response = await dio.post(url, data: param.toJson());
      return handleResponse(response, (json) => Empty.fromJson(json));
    } catch (error) {
      return handleError(error);
    }
  }

  Future<Result> checkInImage(CheckInParam param, MultipartFile image) async {
    var data = FormData.fromMap({
      "image": image,
      "username": param.username,
      "companyId": param.companyId,
      "clientTime": param.clientTime,
      "ip": param.ip,
      "latitude": param.latitude,
      "longitude ": param.longitude,
      "officeId": param.officeId,
      "type":param.type,
      "usedWifi": param.usedWifi
    });
    try {
      RequestOptions options = RequestOptions();
      var sharedPreference = await SharedPreferences.getInstance();
      var token = sharedPreference.getString(Constants.TOKEN);
      options.headers.addAll({
        "Content-Type": "multipart/form-data"
      });
      String url = '${DioManager.PATH_CHECK_IN}/image';
      var response = await dio.post(url,
          data: data, options: options);
      var result =
      handleResponse<Empty>(response, (json) => Empty.fromJson(json));
      return result;
    } catch (error) {
      return handleError(error);
    }
  }

  Future<Result> checkInQR(CheckInParam param) async {
    try {
      String url = '${DioManager.PATH_CHECK_IN}/qrcode';
      var response = await dio.post(url, data: param.toJson());
      return handleResponse(response, (json) => Empty.fromJson(json));
    } catch (error) {
      return handleError(error);
    }
  }

  Future<Result> checkInForm(CheckInParam param) async {
    try {
      String url = '${DioManager.PATH_CHECK_IN}/form';
      var response = await dio.post(url, data: param.toJson());
      return handleResponse(response, (json) => Empty.fromJson(json));
    } catch (error) {
      return handleError(error);
    }
  }
}
