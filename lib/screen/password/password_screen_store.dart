import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
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

  @observable
  bool errorAuth;

  @action
  changePassword(String newPassword, String oldPassword) async {
    isLoading = true;
    errorMessage = null;
    isSuccess = null;
    errorAuth = null;
    try {
      var response = await Injector.authRepository.changePassword(newPassword, oldPassword);
      switch (response.runtimeType) {
        case Success:
          {
            isLoading = false;
            isSuccess = true;
            break;
          }
        case Error:
          {
            isSuccess = false;
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  isLoading = false;
                  errorMessage = (response as Error).msg;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  isLoading = false;
                  errorMessage = Constants.MESSAGE_AUTHENTICATE;
                  errorAuth = true;
                  break;
                }
              default:
                {
                  isLoading = false;
                  errorMessage = (response as Error).msg;
                  break;
                }
            }
            break;
          }
      }
    } catch (error) {
      isLoading = false;
      errorMessage = error.toString();
    }
  }
}
