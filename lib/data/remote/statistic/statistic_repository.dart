import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/statistic.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/utils/handle_respone.dart';

import '../dio.dart';

class StatisticRepository extends BaseRepository {
  Future<Result> getStatisticInfo(GetStatisticParam param) async {
    try {
      var response = await dio.get(DioManager.PATH_STATISTIC,
          queryParameters: param.toJson());
      if (response.data['returnCode'] == 1) {
        return handleResponse(response, (json) => StatisticResponse.fromJson(json));
      }
      throw Exception();
    } catch (error) {
      return handleError(error);
    }
  }
}
