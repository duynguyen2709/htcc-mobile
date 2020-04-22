import 'dart:developer';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/event_detail.dart';
import 'package:hethongchamcong_mobile/data/model/leaving.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'leaving_store.g.dart';

class LeavingStore = _LeavingStore with _$LeavingStore;

abstract class _LeavingStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool shouldRetry = false;

  @observable
  Map<DateTime, List> events;

  @observable
  String errorMsg;

  @observable
  LeavingData leavingData =
      LeavingData(categories: List(), listRequest: List());

  @observable
  List<ListRequest> listRequest;

  @observable
  Map<DateTime, List<EventDetail>> listEvent = Map();

  @observable
  Map<String, double> dataMap = new Map();

  @observable
  Pair status = Pair(key: -1, value: "Tất cả");

  @observable
  int year = DateTime.now().year;

  @observable
  bool isSubmitSuccess;

  @observable
  bool isLoadingSubmitForm = false;

  @observable
  bool isLoadingCancel = false;

  @observable
  bool isCancelSuccess;

  @observable
  bool errAuth;

  @action
  loadData() async {
    try {
      isLoading = true;

      shouldRetry = false;

      var response = await Injector.leavingRepository.loadData(year);

      isLoading = false;

      errAuth =false;

      switch (response.runtimeType) {
        case Success:
          {
            leavingData = (response as Success).data;
            listRequest = leavingData.listRequest;
            mapEvent();
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  errorMsg = (response as Error).msg;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  errorMsg = Constants.MESSAGE_AUTHENTICATE;
                  errAuth = true;
                  break;
                }
              default:
                {
                  errorMsg = (response as Error).msg;
                  break;
                }
            }
            break;
          }
      }
    } catch (error) {
      isLoading = false;
    }
  }

  @action
  filter(Pair pair) {
    log("filter");
    if (pair.key != -1)
      listRequest = leavingData.listRequest
          .where((value) => value.status == pair.key)
          .toList();
    else
      listRequest = leavingData.listRequest;
  }

  mapEvent() async {
    listEvent.clear();
    var formatter1 = new DateFormat('dd/MM/yyyy');
    for (ListRequest request in listRequest) {
      for (Detail detail in request.detail) {
        if (!listEvent.containsKey(DateTime.parse(detail.date))) {
          DateTime date = DateTime.parse(detail.date);
          var list = List<EventDetail>();
          listEvent[date] = list;
          listEvent[date].add(EventDetail(
              createAt: formatter1.format(request.submitDate),
              session: detail.session,
              belongToRequestID: request.leavingRequestId,
              reason: request.reason,
              statusRequest: request.status,
              approver: request.approver));
        } else {
          DateTime date = DateTime.parse(detail.date);
          listEvent[date].add(EventDetail(
              createAt: formatter1.format(request.submitDate),
              session: detail.session,
              belongToRequestID: request.leavingRequestId,
              reason: request.reason,
              statusRequest: request.status,
              approver: request.approver));
        }
      }
    }
  }

  @action
  submit(FormLeaving formLeaving) async {
    isLoadingSubmitForm = true;
    isSubmitSuccess = null;
    errorMsg = null;
    errAuth =false;
    try {
      formLeaving.detail =
          formLeaving.detail.where((value) => value.isCheck).toList();
      if (formLeaving.detail.length > 0) {
        var response = await Injector.leavingRepository.submit(formLeaving);
        isLoadingSubmitForm = false;
        switch (response.runtimeType) {
          case Success:
            {
              isSubmitSuccess = true;
              errorMsg = (response as Success).msg;
              break;
            }
          case Error:
            {
              isSubmitSuccess = false;
              switch ((response as Error).status) {
                case Status.ERROR_NETWORK:
                  {
                    errorMsg = (response as Error).msg;
                    break;
                  }
                case Status.ERROR_AUTHENTICATE:
                  {
                    errorMsg = (response as Error).msg;
                    errAuth = true;
                    break;
                  }
                default:
                  {
                    errorMsg = (response as Error).msg;
                    break;
                  }
              }
            }
        }
      }
    } catch (error) {
      isLoadingSubmitForm = false;
      isSubmitSuccess = false;
      errorMsg = error.toString();
    }
  }

  @action
  cancel(String leavingRequestId, String date) async {
    isLoadingCancel = true;
    isCancelSuccess = null;
    errorMsg = null;
    errAuth =false;
    try {
      var response = await Injector.leavingRepository
          .cancelLeavingRequest(leavingRequestId, date);
      isLoadingCancel = false;
      switch (response.runtimeType) {
        case Success:
          {
            isCancelSuccess = true;
            errorMsg = (response as Success).msg;
            break;
          }
        case Error:
          {
            isCancelSuccess = false;
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  errorMsg = (response as Error).msg;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  errorMsg = (response as Error).msg;
                  errAuth = true;
                  break;
                }
              default:
                {
                  errorMsg = (response as Error).msg;
                  break;
                }
            }
          }
      }
    } catch (error) {
      isLoadingCancel = false;
      isCancelSuccess = false;
      errorMsg = error.toString();
    }
  }
}

class Pair {
  final int key;

  final String value;

  Pair({this.key, this.value});
}
