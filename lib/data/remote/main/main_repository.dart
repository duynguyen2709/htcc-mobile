import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';

import '../dio.dart';

class MainRepository extends BaseRepository {
  Future<int> getCountNotification() async {
    try {
      var pref = await Pref.getInstance();

      User account = User.fromJson(json.decode(pref.getString(Constants.USER)));

      var realPath = DioManager.PATH_COUNT_NOTIFICATION + "/${account.companyId}/${account.username}";

      var response = await dio.get(realPath);

      if (response.data['returnCode'] == 1) {
        return response.data['data']['unreadNotifications'];
      }
      throw Exception();
    } catch (error) {
      return 0;
    }
  }
}
