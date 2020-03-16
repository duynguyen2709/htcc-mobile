import 'dart:developer';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/account/model/account_response.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'account_screen_store.g.dart';

class AccountScreenStore = _AccountScreenStore with _$AccountScreenStore;

abstract class _AccountScreenStore with Store {
  @observable
  bool isLoading = false;

  @observable
  Account account;

  @observable
  bool isConfig = false;

  @observable
  bool edit = false;

  @observable
  bool errorAuthenticate = false;

  @observable
  bool errorNetwork = false;

  @observable
  bool errorUpdate;

  @observable
  String message;

  @action
  getAccount() async {
    isLoading = true;
    try {
      var response = await Injector.accountRepository.getAccount();
      switch (response.runtimeType) {
        case SuccessModel:
          {
            account = response.data as Account;
            log("Success Model");
            isLoading = false;
            break;
          }
        case ErrorModel:
          {
            account = null;
            isLoading = false;
            message = Constants.MESSAGE_EMPTY;
            break;
          }
      }
      isLoading = false;
    } catch (error) {
      account = null;
      isLoading = false;
      message = Constants.MESSAGE_EMPTY;
    }
  }

  @action
  refresh() async {
    isLoading = true;
    errorAuthenticate = false;
    errorNetwork = false;
    try {
      var response = await Injector.accountRepository.refresh();
      switch (response.runtimeType) {
        case SuccessModel:
          {
            account = response.data as Account;
            log("Success Model");
            isLoading = false;
            break;
          }
        case ErrorModel:
          {
            switch (response.message) {
              case Status.ERROR_NETWORK:
                {
                  isLoading = false;
                  message = Constants.MESSAGE_NETWORK;
                  errorNetwork = true;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  isLoading = false;
                  message = Constants.MESSAGE_AUTHENTICATE;
                  errorAuthenticate = true;
                  break;
                }
              default:
                {
                  isLoading = false;
                  message = Constants.MESSAGE_NETWORK;
                  errorNetwork = true;
                  break;
                }
            }
          }
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
      message = Constants.MESSAGE_NETWORK;
      errorNetwork = true;
    }
  }

  @action
  updateAccount() async {
    isLoading = true;
    try {
      var response = await Injector.accountRepository.updateAccount(account);
      switch (response.runtimeType) {
        case SuccessModel:
          {
            account = response.data as Account;
            log("Update Success Model");
            isConfig = false;
            message = Constants.UPDATE_SUCCESSFUL;
            isLoading = false;
            errorUpdate = false;
            break;
          }
        case ErrorModel:
          {
            switch (response.message) {
              case Status.ERROR_NETWORK:
                {
                  isLoading = false;
                  message = Constants.UPDATE_FAIL;
                  errorUpdate = true;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  isLoading = false;
                  message = Constants.MESSAGE_AUTHENTICATE;
                  errorAuthenticate = true;
                  break;
                }
              default:
                {
                  isLoading = false;
                  message = Constants.UPDATE_FAIL;
                  errorUpdate = true;
                  break;
                }
            }
          }
      }
    } catch (error) {
      isLoading = false;
      message = Constants.UPDATE_FAIL;
      errorUpdate = true;
    }
  }
}
