import 'dart:developer';

import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'login_screen_store.g.dart';

class LoginScreenStore = _LoginScreenStore with _$LoginScreenStore;

abstract class _LoginScreenStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool checkLogin;

  @action
  login() async {
    isLoading = true;
    try {
      var response = await Injector.loginRepository.login();
      switch (response.runtimeType) {
        case SuccessModel:
          {
            log("Success Model");
            checkLogin = true;
            break;
          }
        case ErrorModel:
          {
            log("Error Model");
            checkLogin = false;
            break;
          }
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }
}
