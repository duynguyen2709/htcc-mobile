import 'package:hethongchamcong_mobile/data/base/result.dart';
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
  changePassword(String newPassword, String oldPassword) async {
    isLoading = true;
    errorMessage = null;
    isSuccess = null;
    try {
      var response = await Injector.authRepository.changePassword(newPassword, oldPassword);
      switch (response.runtimeType) {
        case Success:
          {
            isSuccess = true;
            break;
          }
        case Error:
          {
            isSuccess = false;
            errorMessage = (response as Error).msg;
            break;
          }
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }
}
