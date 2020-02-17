import 'package:hethongchamcong_mobile/data/remote/account/account_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/login/login_repository.dart';

class Injector {
  static final AccountRepository accountRepository = AccountRepository();
  static final LoginRepository loginRepository = LoginRepository();
}
