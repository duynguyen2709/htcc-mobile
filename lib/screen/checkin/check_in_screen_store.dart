import 'package:hethongchamcong_mobile/data/remote/base/result.dart';
import 'package:hethongchamcong_mobile/data/remote/checkin/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';
import 'dart:developer';

part 'check_in_screen_store.g.dart';

class CheckInStore extends _CheckInStore with _$CheckInStore{
}

abstract class _CheckInStore with Store{
  @observable
  bool isLoading = false;

  @observable
  bool getInfoCheckInSuccess;

  @observable
  bool checkInSuccess;

  @observable
  String errorMsg;

  @action
  getCheckInInfo(String companyId, String username, String date) async {
    getInfoCheckInSuccess=null;
    errorMsg=null;

    try{
      var response = await Injector.checkInRepository.getCheckInInfo(companyId: companyId,username: username ,date: date);
      if(response is Success){
        getInfoCheckInSuccess = true;
      }
      else{
        getInfoCheckInSuccess = false;
        errorMsg = (response as Error).msg;
      }
    }
    catch (error){
      errorMsg= error.toString();
    }
  }

  @action
  checkIn(CheckInParam param) async {
    checkInSuccess=null;
    errorMsg=null;

    try{
      var response = await Injector.checkInRepository.checkIn(param);
      if(response is Success){
        checkInSuccess = true;
      }
      else{
        checkInSuccess = false;
        errorMsg = (response as Error).msg;
      }
    }
    catch (error){
      errorMsg= error.toString();
    }
  }

}