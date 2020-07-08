import 'dart:developer';

import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/statistic.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'statistic_store.g.dart';

class StatisticStore = _StatisticStore with _$StatisticStore;

abstract class _StatisticStore with Store {
  @observable
  bool isLoading;

  @observable
  bool isSuccess;

  @observable
  StatisticResponse result;

  @observable
  String msg;

  @action
  getStatisticInfo(GetStatisticParam param) async {
    isLoading = true;
    msg = null;
    result = null;
    isSuccess =null;
    try {
      Result response = await Injector.statisticRepository.getStatisticInfo(param);
      switch (response.runtimeType) {
        case Success:
          {
            isLoading= false;
            result = (response as Success).data;
            msg = (response as Success).msg;
            isSuccess=true;
            break;
          }
        case Error:
          {
            isLoading= false;
            isSuccess=false;
            switch ((response as Error).status) {
              case Status.LOGIN_FAIL:
                {
                  msg = (response as Error).msg;
                  break;
                }
              case Status.ERROR_NETWORK:
                {
                  msg = (response as Error).msg;
                  break;
                }
              default:
                {
                  msg = (response as Error).msg;
                  break;
                }
            }
            break;
          }
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }
}
