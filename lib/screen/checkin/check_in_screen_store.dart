import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'check_in_screen_store.g.dart';

class CheckInStore extends _CheckInStore with _$CheckInStore {}

abstract class _CheckInStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool getInfoCheckInSuccess;

  @observable
  bool checkInSuccess;

  @observable
  String errorMsg;

  @observable
  bool errorAuth;

  @action
  getCheckInInfo(String companyId, String username, String date) async {
    getInfoCheckInSuccess = null;
    errorMsg = null;
    errorAuth =null;
    try {
      var response = await Injector.checkInRepository
          .getCheckInInfo(companyId: companyId, username: username, date: date);
      switch (response.runtimeType) {
        case Success:
          {
            getInfoCheckInSuccess = true;
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  getInfoCheckInSuccess = false;
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
                  getInfoCheckInSuccess = false;
                  errorMsg = (response as Error).msg;
                  break;
                }
            }
          }
      }
    } catch (error) {
      errorMsg = error.toString();
    }
  }

  @action
  checkIn(CheckInParam param) async {
    checkInSuccess = null;
    errorMsg = null;
    isLoading = true;
    errorAuth =null;
    try {
      var response = await Injector.checkInRepository.checkIn(param);
      if (response is Success) {
        isLoading =false;
        checkInSuccess = true;
      } else {
        checkInSuccess = false;
        switch ((response as Error).status) {
          case Status.ERROR_NETWORK:
            {
              isLoading = false;
              errorMsg = (response as Error).msg;
              break;
            }
          case Status.ERROR_AUTHENTICATE:
            {
              isLoading = false;
              errorMsg = Constants.MESSAGE_AUTHENTICATE;
              errorAuth = true;
              break;
            }
          default:
            {
              isLoading = false;
              errorMsg = (response as Error).msg;
              break;
            }
        }
      }
    } catch (error) {
      errorMsg = error.toString();
      isLoading = false;
    }
  }
}
