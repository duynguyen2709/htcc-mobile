import 'dart:convert';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/screen.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dio.dart';

class MainRepository extends BaseRepository {
  Future<int> getCountNotification() async {
    try {
      var pref = await Pref.getInstance();

      User account = User.fromJson(json.decode(pref.getString(Constants.USER)));

      var realPath = DioManager.PATH_COUNT_NOTIFICATION + "/${account.companyId}/${account.username}";

      var response = await dio.get(realPath, queryParameters: {'screens': '1,2,3,4,5,6,7,8,9,11'});

      if (response.data['returnCode'] == 1) {
        var screen = ScreenResponse.fromJson(response.data);
        pref.setString(Constants.LIST_SCREEN, screenResponseToJson(screen));
        screenResponse.data = screen.data;
        return response.data['data']['unreadNotifications'];
      }
      throw Exception();
    } catch (error) {
      return 0;
    }
  }

  getCacheListScreen() async {
    try {
      var sharedPreference = await SharedPreferences.getInstance();
      screenResponse.data = screenResponseFromJson(sharedPreference.getString(Constants.LIST_SCREEN)).data;
    } catch (error) {}
  }
}
