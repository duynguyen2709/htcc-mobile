import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/contact.dart';
import 'package:hethongchamcong_mobile/data/model/filter_list.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'contact_store.g.dart';

class ContactStore extends _ContactStore with _$ContactStore {}

abstract class _ContactStore with Store {
  @observable
  bool isLoading;


  @observable
  bool getListContactSuccess;

  @observable
  bool getListFilterSuccess;

  @observable
  bool getMoreSuccess;

  @observable
  List<Contact> listContact = new List();

  @observable
  FilterList listFilter;

  @observable
  bool errorAuth;

  @observable
  String errorMsg;


  @observable
  int perPage = 10;

  @observable
  bool canLoadMore = true;
  @action
  getFilterList() async{
    getListFilterSuccess = null;
    errorMsg = null;
    errorAuth = null;
    try {
      var response = await Injector.contactRepository
          .getListFilter();
      switch (response.runtimeType) {
        case Success:
          {
            getListFilterSuccess = true;
            listFilter = (response as Success).data;
            listFilter.departmentList.add("Tất cả");
            listFilter.officeIdList.add("Tất cả");
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  getListFilterSuccess = false;
                  errorMsg = (response as Error).msg;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  errorMsg = Constants.MESSAGE_AUTHENTICATE;
                  errorAuth = true;
                  break;
                }
              default:
                {
                  getListFilterSuccess = false;
                  errorMsg = (response as Error).msg;
                  break;
                }
            }
          }
      }
    } catch (error) {
      errorMsg = error.toString();
      getListFilterSuccess = false;
    }
  }
  @action
  getContact(
      {@required String departmentId, @required String officeId,@required int page, int perPage}) async {
    getListContactSuccess = null;
    errorMsg = null;
    errorAuth = null;
    isLoading = true;
    if (perPage != null) this.perPage = perPage;
    try {
      var response = await Injector.contactRepository
          .getListContact(departmentId, officeId,null, page, this.perPage);
      switch (response.runtimeType) {
        case Success:
          {
            getListContactSuccess = true;
            listContact = (response as Success).data;
            isLoading = false;
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  getListContactSuccess = false;
                  errorMsg = (response as Error).msg;
                  isLoading = false;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  errorMsg = Constants.MESSAGE_AUTHENTICATE;
                  errorAuth = true;
                  isLoading = false;
                  break;
                }
              default:
                {
                  getListContactSuccess = false;
                  errorMsg = (response as Error).msg;
                  isLoading = false;
                  break;
                }
            }
          }
      }
    } catch (error) {
      errorMsg = error.toString();
      getListContactSuccess = false;
      isLoading = false;
    }
  }
  @action
  searchContact(
      { String keyword,@required int page, int perPage}) async {
    getListContactSuccess = null;
    errorMsg = null;
    errorAuth = null;
    isLoading = true;
    if (perPage != null) this.perPage = perPage;
    try {
      var response = await Injector.contactRepository
          .getListContact(null, null,keyword, page, this.perPage);
      switch (response.runtimeType) {
        case Success:
          {
            getListContactSuccess = true;
            listContact = (response as Success).data;
            isLoading = false;
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  getListContactSuccess = false;
                  errorMsg = (response as Error).msg;
                  isLoading = false;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  errorMsg = Constants.MESSAGE_AUTHENTICATE;
                  errorAuth = true;
                  isLoading = false;
                  break;
                }
              default:
                {
                  getListContactSuccess = false;
                  errorMsg = (response as Error).msg;
                  isLoading = false;
                  break;
                }
            }
          }
      }
    } catch (error) {
      errorMsg = error.toString();
      getListContactSuccess = false;
      isLoading = false;
    }
  }
  @action
  getMoreContact(
      {String departmentId, String officeId,String keyword,int page, int perPage}) async {
    getListContactSuccess = null;
    errorMsg = null;
    errorAuth = null;
    if (perPage != null) this.perPage = perPage;
    try {
      var response = await Injector.contactRepository
          .getListContact(departmentId, officeId, keyword, page, this.perPage);
      switch (response.runtimeType) {
        case Success:
          {
            getListContactSuccess = true;
            if ((response as Success).data.length > 0)
              listContact.addAll((response as Success).data);
            else canLoadMore=false;
            break;
          }
        case Error:
          {
            canLoadMore=false;
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  getListContactSuccess = false;
                  errorMsg = (response as Error).msg;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  errorMsg = Constants.MESSAGE_AUTHENTICATE;
                  errorAuth = true;
                  break;
                }
              default:
                {
                  getListContactSuccess = false;
                  errorMsg = (response as Error).msg;
                  break;
                }
            }
          }
      }
    } catch (error) {
      errorMsg = error.toString();
      getListContactSuccess = false;
    }
  }

}
