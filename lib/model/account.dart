import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/repository.dart';
import 'package:scoped_model/scoped_model.dart';

class AccountModel extends Model {
  AccountModel(@required this._accountRepository);

  final AccountRepository _accountRepository;
  bool isLoading = false;

  Account _account;

  Account get account => _account;

  void getAccount() async {
    isLoading = true;
    notifyListeners();
    _accountRepository.getAccount().then((value) {
      isLoading = false;
      _account = value;
      notifyListeners();
    }).catchError((error) {});
  }

  static AccountModel of(BuildContext context) =>
      ScopedModel.of<AccountModel>(context);
}

class Account {
  Account(this.gender, this.age, this.city,
      {@required this.linkAvatar, @required this.name, @required this.phone});

  final String linkAvatar;
  final String name;
  final String phone;
  final String gender;
  final String age;
  final String city;
}
