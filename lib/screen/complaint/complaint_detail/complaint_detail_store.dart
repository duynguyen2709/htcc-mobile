import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/complaint.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'complaint_detail_store.g.dart';

class ComplaintDetailStore extends _ComplaintDetailStore with _$ComplaintDetailStore {}

abstract class _ComplaintDetailStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool errorAuth;

  @observable
  String errorMsg;

  @observable
  bool postComplaintSuccess;

  @action
  rePostComplaint(RePostComplaintParam rePostComplaintParam) async {
    postComplaintSuccess = null;
    errorMsg = null;
    errorAuth = null;
    isLoading = true;
    try {
      var response = await Injector.complaintRepository.rePostComplaint(rePostComplaintParam);
      switch (response.runtimeType) {
        case Success:
          {
            postComplaintSuccess = true;
            isLoading=false;
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  postComplaintSuccess = false;
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
                  postComplaintSuccess = false;
                  errorMsg = (response as Error).msg;
                  break;
                }
            }
            isLoading=false;

          }
      }
    } catch (error) {
      errorMsg = error.toString();
      isLoading=false;

    }
  }
}