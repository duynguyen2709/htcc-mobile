import 'package:hethongchamcong_mobile/model/account.dart';

class AccountRepository{
  Future<Account> getAccount() async {
    await Future.delayed(Duration(seconds: 2));
    return Account("Nam","34","asdasd",linkAvatar: 'https://www.freepik.com/free-photos-vectors/png' , name: 'John', phone: 'Smith');
  }
}