import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/api_response.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_info.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/data/model/empty.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dio.dart';

class CheckInRepository extends BaseRepository {
  CheckInRepository() : super();

  Future<Result> getCheckInInfo({String companyId, String username, String date}) async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      String datePath = date != null ? '?date=$date' : '';
      String url = '${DioManager.PATH_CHECK_IN}/$companyId/$username' + '$datePath';
      var response = await dio.get(url);
      ApiResponse<CheckInInfo> res = ApiResponse.fromJson(response.data, (json) => CheckInInfo.fromJson(json));
      if (res.returnCode == 1) {
        sharedPreference.setString(Constants.CHECK_IN_INFO, json.encode(res.data.toJson()));
        return Success(data: res.data, msg: res.returnMessage);
      } else {
        return Error(status: Status.FAIL, msg: res.returnMessage);
      }
    } catch (error) {
      return Error(status: Status.FAIL, msg: "Vui lòng kiểm tra lại kết nối mạng.");
    }
  }

  Future<Result> checkIn(CheckInParam param) async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      var response = await dio.post(DioManager.PATH_CHECK_IN, data: param.toJson());
      ApiResponse<Empty> res = ApiResponse.fromJson(response.data, (json) => Empty.fromJson(json));
      if (res.returnCode == 1) {
        sharedPreference.setString(Constants.CHECK_IN_INFO, json.encode(response.data["data"]));
        return Success(data: null, msg: res.returnMessage);
      } else {
        return Error(status: Status.FAIL, msg: res.returnMessage);
      }
    } catch (error) {
      return Error(status: Status.FAIL, msg: "Vui lòng kiểm tra lại kết nối mạng.");
    }
  }
}
