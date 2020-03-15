import 'package:hethongchamcong_mobile/data/remote/account/account_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/auth/auth_repository.dart';

class Injector {
  static final AccountRepository accountRepository = AccountRepository();
  static final AuthRepository authRepository = AuthRepository();
}
