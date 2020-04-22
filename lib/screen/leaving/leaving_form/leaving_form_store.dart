import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'leaving_form_store.g.dart';

class LeavingFormStore = _LeavingFormStore with _$LeavingFormStore;

abstract class _LeavingFormStore with Store {

  @observable
  bool isLoadingSubmitForm = false;

  @observable
  String msg;

  @observable
  bool isSubmitSuccess;

  @observable
  Map<DateTime, List> events;

  @observable
  bool errAuth;
  @action
  submit(FormLeaving formLeaving) async {
    isLoadingSubmitForm = true;
    isSubmitSuccess =null;
    msg = null;
    errAuth=false;
    try {
      formLeaving.detail = formLeaving.detail.where((value) => value.isCheck).toList();
      if (formLeaving.detail.length > 0) {
        var response = await Injector.leavingRepository.submit(formLeaving);
        isLoadingSubmitForm = false;
        switch (response.runtimeType) {
          case Success:
            {
              isSubmitSuccess = true;
              msg = (response as Success).msg;
              break;
            }
          case Error:
            {
              isSubmitSuccess = false;
              switch ((response as Error).status) {
                case Status.ERROR_NETWORK:
                  {
                    msg = (response as Error).msg;
                    break;
                  }
                case Status.ERROR_AUTHENTICATE:
                  {
                    msg = (response as Error).msg;
                    errAuth=true;
                    break;
                  }
                default:
                  {
                    msg = (response as Error).msg;
                    break;
                  }
              }
            }
        }
      }
    } catch (error) {
      isLoadingSubmitForm = false;
      isSubmitSuccess = false;
      msg = error.toString();
    }
  }
}