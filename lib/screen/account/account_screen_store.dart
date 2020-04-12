import 'dart:developer';
import 'dart:io';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'account_screen_store.g.dart';

class AccountScreenStore = _AccountScreenStore with _$AccountScreenStore;

abstract class _AccountScreenStore with Store {
  @observable
  bool isLoading = false;

  @observable
  User account;

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

  @observable
  File image;

  @action
  getAccount() async {
    isLoading = true;
    image = null;
    try {
      var response = await Injector.accountRepository.getAccount();
      isLoading = false;
      switch (response.runtimeType) {
        case Success:
          {
            account = (response as Success).data as User;
            log("Success Model");
            break;
          }
        case Error:
          {
            account = null;
            message = Constants.MESSAGE_EMPTY;
            break;
          }
      }
    } catch (error) {
      account = null;
      isLoading = false;
      message = Constants.MESSAGE_EMPTY;
    }
  }

  @action
  refresh() async {
    isLoading = true;
    image = null;
    errorAuthenticate = false;
    errorNetwork = false;
    try {
      var response = await Injector.accountRepository.refresh();
      isLoading = false;
      switch (response.runtimeType) {
        case Success:
          {
            account = (response as Success).data as User;
            log("Success Model");
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  //message = Constants.MESSAGE_NETWORK;
                  errorNetwork = true;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  //message = Constants.MESSAGE_AUTHENTICATE;
                  errorAuthenticate = true;
                  break;
                }
              default:
                {
                  //message = Constants.MESSAGE_NETWORK;
                  errorNetwork = true;
                  break;
                }
            }
            message = (response as Error).msg;
          }
      }
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
      var response = await Injector.accountRepository.updateAccount(account, image);
      isLoading = false;
      switch (response.runtimeType) {
        case Success:
          {
            account = (response as Success).data as User;
            log("Update Success Model");
            isConfig = false;
            //message = Constants.UPDATE_SUCCESSFUL;
            message = (response as Success).msg;
            errorUpdate = false;
            image = null;
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  //message = Constants.UPDATE_FAIL;
                  errorUpdate = true;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  //message = Constants.MESSAGE_AUTHENTICATE;
                  errorAuthenticate = true;
                  break;
                }
              default:
                {
                  //message = Constants.UPDATE_FAIL;
                  errorUpdate = true;
                  break;
                }
            }
            message = (response as Error).msg;
          }
      }
    } catch (error) {
      isLoading = false;
      message = Constants.UPDATE_FAIL;
      errorUpdate = true;
    }
  }
}
