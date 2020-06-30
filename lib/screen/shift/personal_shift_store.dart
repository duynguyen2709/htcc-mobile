import 'dart:developer';

import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/shift.dart';
import 'package:hethongchamcong_mobile/data/model/statistic.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'personal_shift_store.g.dart';

class PersonalShiftStore = _PersonalShiftStore with _$PersonalShiftStore;

abstract class _PersonalShiftStore with Store {
  @observable
  bool isLoading;

  @observable
  bool isSuccess;

  @observable
  List<ShiftArrangement> result;


  String curMonth="";


  @observable
  String msg;

  @action
  getPersonalShift(String month) async {
    curMonth=month;
    isLoading = true;
    msg = null;
    result = null;
    isSuccess =null;
    try {
      Result response = await Injector.shiftRepository.getPersonalShift(month);
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
