import 'dart:async';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/presenter/base_presenter.dart';

abstract class SplashContract extends BaseContract {
  void goToNextScreen(String token, HashMap<String, Object> hashMap);
}

class SplashPresenter extends BasePresenter<SplashContract> {
  SplashPresenter(BaseContract contractView) {
    this.view = contractView;
  }

  void authenticate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _isHaveData = prefs.getString(Constants.isLogin) ?? "";
    final _userName = prefs.getString(Constants.userName) ?? "";
    final _password = prefs.getString(Constants.password) ?? "";

    //TODO Call API from server and do sth
    await new Future.delayed(const Duration(seconds: 2));
    //TODO Pass token in paramater
    if (_isHaveData.isEmpty) {
      view.goToNextScreen(Constants.isLogin, null);
    } else {
      view.goToNextScreen("",null);
    }
  }
}
