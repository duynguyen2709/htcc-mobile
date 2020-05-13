import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/api_response.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/exception/custom_exception.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/notification.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:hethongchamcong_mobile/data/utils/handle_respone.dart';

class NotificationRepository extends BaseRepository {
  Future<Result> getListNotification(int index, int size) async {
    try {
      var pref = await Pref.getInstance();

      User account = User.fromJson(json.decode(pref.getString(Constants.USER)));

      var realPath = DioManager.PATH_NOTIFICATION + "/${account.companyId}/${account.username}";

      var response = await dio.get(realPath, queryParameters: {'index': index, 'size': size});

      ListApiResponse<NotificationPush> result = ListApiResponse.fromJson(response.data, (json) => NotificationPush.fromJson(json));

      if (result.returnCode == 1) {
        return Success(data: result.data);
      }
      throw UnValidResponseException(listResponse: result);
    } catch (error) {
      return handleError(error);
    }
  }

  Future<void> updateStatusNotification(String id, int type) async {
    try {
      var pref = await Pref.getInstance();

      User account = User.fromJson(json.decode(pref.getString(Constants.USER)));

      Map formData = {
        "clientId": 0,
        "companyId": account.companyId,
        "notiId": id,
        "type": type,
        "username": account.username,
      };

      var response = await dio.post(DioManager.PATH_NOTIFICATION_STATUS, data: formData);
    } catch (error) {}
  }
}
