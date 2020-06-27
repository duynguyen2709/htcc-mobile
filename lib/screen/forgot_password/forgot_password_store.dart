import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'forgot_password_store.g.dart';

class ForgotPasswordStore = _ForgotPasswordStore with _$ForgotPasswordStore;

abstract class _ForgotPasswordStore with Store {
  @observable
  bool isLoading = false;

  @observable
  String msg = '';

  submit(String code, String username) async {
    try {
      isLoading = true;
      msg = '';
      msg = await Injector.authRepository.resetPass(code, username);
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }
}
