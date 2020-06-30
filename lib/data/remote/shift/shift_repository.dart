import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/empty.dart';
import 'package:hethongchamcong_mobile/data/model/leaving.dart';
import 'package:hethongchamcong_mobile/data/model/shift.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:hethongchamcong_mobile/data/utils/handle_respone.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ShiftRepository extends BaseRepository {
  Future<Result> getCompanyWorkingDay(String month) async {
    try {
      var pref  = await SharedPreferences.getInstance();
      String jsonUser = pref.getString(Constants.USER);
      if (jsonUser != null && jsonUser.isNotEmpty){
        User user = User.fromJson(json.decode(jsonUser));
        String realPath = DioManager.PATH_WORKING_DAY + "/${user.companyId}/$month";
        var response = await dio.get(realPath);
        var result =
        handleResponse<WorkingDayResponse>(response, (json) => WorkingDayResponse.fromJson(json));
        return result;
      }
      else{
        return Error(status: Status.ERROR_AUTHENTICATE);
      }

    } catch (error) {
      return handleError(error);
    }
  }

  Future<Result> getPersonalShift(String month) async {
    try {
      var pref  = await SharedPreferences.getInstance();
      String jsonUser = pref.getString(Constants.USER);
      if (jsonUser != null && jsonUser.isNotEmpty){
        User user = User.fromJson(json.decode(jsonUser));
        String realPath = DioManager.PATH_PERSONAL_SHIFT + "/${user.companyId}/${user.username}/$month";
        var response = await dio.get(realPath);
        var result =
        handleListResponse<ShiftArrangement>(response, (json) => ShiftArrangement.fromJson(json));
        return result;
      }
      else{
        return Error(status: Status.ERROR_AUTHENTICATE);
      }

    } catch (error) {
      return handleError(error);
    }
  }
}
