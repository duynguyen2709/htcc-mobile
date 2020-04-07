import 'dart:developer';

import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/leaving.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
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
  LeavingData leavingData;

  @observable
  List<ListRequest> listRequest;

  @observable
  Map<String, double> dataMap = new Map();

  @observable
  Pair status = Pair(key: -1, value: "Tất cả");

  @observable
  int year = DateTime.now().year;

  @action
  loadData() async {
    try {
      isLoading = true;

      shouldRetry = false;

      var response = await Injector.leavingRepository.loadData(year);

      isLoading = false;

      switch (response.runtimeType) {
        case Success:
          {
            leavingData = (response as Success).data;
            listRequest = leavingData.listRequest;
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  shouldRetry = true;
                  errorMsg = (response as Error).msg;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  errorMsg = Constants.MESSAGE_AUTHENTICATE;
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
    if(pair.key != -1)
      listRequest = leavingData.listRequest.where((value) => value.status == pair.key).toList();
    else listRequest = leavingData.listRequest;
  }
}

class Pair {
  final int key;

  final String value;

  Pair({this.key, this.value});
}
