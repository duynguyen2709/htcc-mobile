import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_repository.dart';

import 'model/AccountResponse.dart';

class AccountRepository extends BaseRepository {
  static final AccountRepository _singleton = AccountRepository._internal();

  factory AccountRepository() {
    return _singleton;
  }

  AccountRepository._internal();

  Future<BaseModel> getAccount() async {
    await Future.delayed(Duration(seconds: 5),(){});
    return SuccessModel(AccountData(linkAvatar: "dasdas",name: "asdas", phone: "asdasd",gender: "dasdas", age: "asdas", city: "dsadas"), "dasd");
  }
}
