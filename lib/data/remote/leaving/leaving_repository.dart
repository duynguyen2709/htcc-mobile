import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/leaving.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:hethongchamcong_mobile/data/utils/handle_respone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'form_date.dart';

class LeavingRepository extends BaseRepository {
  Future<Result> loadData(int year) async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();

      User account = User.fromJson(json.decode(sharedPreference.getString(Constants.USER)));

      var realPath = DioManager.PATH_LEAVING + "/${account.companyId}/${account.username}/$year";

      var response = await dio.get(realPath);

      var result = handleResponse<LeavingData>(response, (json) => LeavingData.fromJson(json));

      return result;
    } catch (error) {
      return handleError(error);
    }
  }

  Future<Result> submit(FormLeaving formLeaving) async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();

      User account = User.fromJson(json.decode(sharedPreference.getString(Constants.USER)));

      formLeaving.companyId = account.companyId;

      formLeaving.clientTime = DateTime.now().millisecondsSinceEpoch;

      formLeaving.username = account.username;

      var response = await dio.post(DioManager.PATH_LEAVING, data: formLeaving.toJson());

      if (response.data['returnCode'] == 1) {
        return Success();
      } else {
        if (response.statusCode == 401) return Error(status: Status.ERROR_AUTHENTICATE);
      }

      return Error(status: Status.FAIL, msg: "Đã xảy ra lỗi trong quá trình xử lý.");
    } catch (error) {
      handleError(error);
    }
  }
}
