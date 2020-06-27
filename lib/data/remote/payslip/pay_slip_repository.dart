import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/api_response.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/exception/custom_exception.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/payslip.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';

class PayslipRepository extends BaseRepository {
  Future<Result> getPayslip(String time) async {
    try {
      var pref = await Pref.getInstance();

      User account = User.fromJson(json.decode(pref.getString(Constants.USER)));

      var response = await dio.get(DioManager.PATH_PAYSLIP, queryParameters: {
        'companyId': account.companyId,
        'username': account.username,
        'yyyyMM': time,
        'count': 10,
      });
      ListApiResponse<Payslip> result = ListApiResponse.fromJson(response.data, (json) => Payslip.fromJson(json));

      if (result.returnCode == 1) {
        return Success(data: result.data);
      }
      throw UnValidResponseException(listResponse: result);
    } catch (error) {
      return handleError(error);
    }
  }
}
