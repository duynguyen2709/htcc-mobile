import 'dart:convert';

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
      var sharedPreference = await SharedPreferences.getInstance();
      String datePath = date != null ? '?date=$date' : '';
      String url = '${DioManager.PATH_CHECK_IN}/$companyId/$username' + '$datePath';
      var response = await dio.get(url);
      var result = handleResponse<CheckInInfo>(response, (json) => CheckInInfo.fromJson(json));
      if(result is Success){
        sharedPreference.setString(Constants.CHECK_IN_INFO, json.encode(result.data.toJson()));
      }
      return result;
    } catch (error) {
      return handleError(error);
    }
  }

  Future<Result> checkIn(CheckInParam param) async {
    try {
      var response = await dio.post(DioManager.PATH_CHECK_IN, data: param.toJson());
      return handleResponse(response, (json) => Empty.fromJson(json));
    } catch (error) {
      return handleError(error);
    }
  }
}
