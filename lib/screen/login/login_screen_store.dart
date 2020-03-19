import 'dart:developer';

import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'login_screen_store.g.dart';

class LoginScreenStore = _LoginScreenStore with _$LoginScreenStore;

abstract class _LoginScreenStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool checkLogin;

  @observable
  String errorMessage;

  @action
  login(String userName, String password, String companyId) async {
    isLoading = true;
    errorMessage = null;
    checkLogin = null;
    try {
      var response = await Injector.authRepository.login(userName, password, companyId);
      switch (response.runtimeType) {
        case Success:
          {
            log("Success Model");
            checkLogin = true;
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.LOGIN_FAIL:
                {
                  log("Error Model");
                  errorMessage = "Thông tin đăng nhập không chính xác!";
                  checkLogin = false;
                  break;
                }
              case Status.ERROR_NETWORK:
                {
                  log("Error Model");
                  errorMessage = "Lỗi kết nối!";
                  checkLogin = false;
                  break;
                }
              default:
                {
                  errorMessage = "Thông tin đăng nhập không chính xác!";
                  log("Error Model");
                  checkLogin = false;
                  break;
                }
            }
            break;
          }
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }
}
