import 'dart:developer';

import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'password_screen_store.g.dart';

class PasswordScreenStore = _PasswordScreenStore with _$PasswordScreenStore;

abstract class _PasswordScreenStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isSuccess;

  @observable
  String errorMessage;

  @action
  changePassword(String userName, String newPassword, String oldPassword,
      String companyId) async {
    isLoading = true;
    errorMessage = null;
    isSuccess = null;
    try {
      var response = await Injector.authRepository
          .changePassword(userName, newPassword, oldPassword, companyId);
      switch (response.runtimeType) {
        case SuccessModel:
          {
            isSuccess = true;
            break;
          }
        case ErrorModel:
          {
            isSuccess = false;
            errorMessage = response.message;
            break;
          }
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }
}
