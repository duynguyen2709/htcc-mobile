import 'dart:developer';

import 'package:hethongchamcong_mobile/data/remote/account/model/AccountResponse.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'account_screen_store.g.dart';

class AccountScreenStore = _AccountScreenStore with _$AccountScreenStore;

abstract class _AccountScreenStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isShimmering = true;

  @observable
  AccountData accountData;

  @observable
  bool edit = false;

  @observable
  bool error = false;

  @action
  getAccount() async {
    isLoading = true;
    if (isShimmering == false)
      isShimmering = true;
    try {
      var response = await Injector.accountRepository.getAccount();
      switch (response.runtimeType) {
        case SuccessModel:
          {
            accountData = response.data as AccountData;
            log("Success Model");
            isLoading = false;
            isShimmering = false;
            break;
          }
        case ErrorModel:
          {
            log("Error Model");
            isLoading = false;
            isShimmering = false;
            //fake data error
            accountData = AccountData(
                linkAvatar: "",
                name: "",
                phone: "",
                gender: "",
                age: ",",
                city: "");
            error = false;
            break;
          }
      }
      isLoading = false;
      isShimmering = false;
    } catch (error) {
      isLoading = false;
      isShimmering = false;
    }
  }
}
