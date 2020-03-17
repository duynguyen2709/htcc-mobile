import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_response.dart';
import 'package:hethongchamcong_mobile/data/remote/base/result.dart';
import 'package:hethongchamcong_mobile/data/remote/checkin/model/check_in_info_response.dart';
import 'package:hethongchamcong_mobile/data/remote/checkin/model/check_in_param.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dio.dart';

class CheckInRepository extends BaseRepository {
  CheckInRepository() : super();

  Future<Result<CheckInInfo>> getCheckInInfo(
      {String companyId, String username, String date}) async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      String token = sharedPreference.getString(Constants.TOKEN);
      String datePath = date != null ? '?date=$date' : '';
      String url = '${DioManager.PATH_CHECK_IN}/$companyId/$username' + '$datePath';
      var response = await dio.get(url,
          options: Options(headers: {"authorization": "Bearer $token"}));
      if (response.data["data"] != null) {
        CheckInInfoResponse res = CheckInInfoResponse(response.data);
        print(res);
        if (res.returnCode == 1 && res.data != null) {
          var sharedPreference = await SharedPreferences.getInstance();
          sharedPreference.setString(
              Constants.CHECK_IN_INFO, json.encode(res.data.toJson()));
          return Result<CheckInInfo>.success(res.returnMessage, res.data);
        }
      }

      return Result<CheckInInfo>.error(response.data["returnMessage"]);
    } catch (error) {
      return Result<CheckInInfo>.error("Vui lòng kiểm tra lại kết nối mạng.");
    }
  }

  Future<Result<bool>> checkIn(CheckInParam param) async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      String token = sharedPreference.getString(Constants.TOKEN);
      var response = await dio.post(DioManager.PATH_CHECK_IN,
          options: Options(headers: {"authorization": "Bearer $token"}),
      data: param.toJson());
      if (response.data["data"] != null) {
        CheckInInfoResponse res = CheckInInfoResponse(response.data);
        print(res);
        if (res.returnCode == 1 && res.data != null) {
          return Result<bool>.success(res.returnMessage, true);
        }
      }

      return Result<bool>.error(response.data["returnMessage"]);
    } catch (error) {
      return Result<bool>.error("Vui lòng kiểm tra lại kết nối mạng.");
    }
  }
}
