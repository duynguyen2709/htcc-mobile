import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/complaint.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'complaint_store.g.dart';

class ComplaintStore extends _ComplaintStore with _$ComplaintStore {}

abstract class _ComplaintStore with Store {
  @observable
  bool isLoading;

  @observable
  bool postComplaintSuccess;

  @observable
  bool getListComplaintSuccess;

  @observable
  List<Complaint> listComplaint = new List();

  @observable
  bool errorAuth;

  @observable
  String errorMsg;

  @observable
  DateTime monthQuery;

  @action
  postComplaint(CreateComplaintParam param) async {
    postComplaintSuccess = null;
    errorMsg = null;
    errorAuth = null;
    isLoading = true;
    try {
      var response = await Injector.complaintRepository.postComplaint(param);
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

  @action
  getComplaint(DateTime month) async {
    getListComplaintSuccess = null;
    errorMsg = null;
    errorAuth = null;
    isLoading = true;
    monthQuery = month;
    try {
      var response = await Injector.complaintRepository
          .getListComplaint(DateFormat('yyyyMM').format(month));
      switch (response.runtimeType) {
        case Success:
          {
            getListComplaintSuccess = true;
            if ((response as Success).data.length > 0)
              listComplaint = (response as Success).data;
            else
              listComplaint.clear();
            isLoading=false;
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  getListComplaintSuccess = false;
                  errorMsg = (response as Error).msg;
                  isLoading=false;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  errorMsg = Constants.MESSAGE_AUTHENTICATE;
                  errorAuth = true;
                  isLoading=false;
                  break;
                }
              default:
                {
                  getListComplaintSuccess = false;
                  errorMsg = (response as Error).msg;
                  isLoading=false;
                  break;
                }
            }
          }
      }
    } catch (error) {
      errorMsg = error.toString();
      getListComplaintSuccess = false;
      isLoading=false;
    }
  }

  @action
  refresh() async{
    getListComplaintSuccess = null;
    errorMsg = null;
    errorAuth = null;
    isLoading = true;
    try {
      var response = await Injector.complaintRepository
          .getListComplaint(DateFormat('yyyyMM').format(monthQuery));
      switch (response.runtimeType) {
        case Success:
          {
            getListComplaintSuccess = true;
            if ((response as Success).data.length > 0)
              listComplaint = (response as Success).data;
            else
              listComplaint.clear();
            isLoading=false;
            break;
          }
        case Error:
          {
            switch ((response as Error).status) {
              case Status.ERROR_NETWORK:
                {
                  getListComplaintSuccess = false;
                  errorMsg = (response as Error).msg;
                  isLoading=false;
                  break;
                }
              case Status.ERROR_AUTHENTICATE:
                {
                  errorMsg = Constants.MESSAGE_AUTHENTICATE;
                  errorAuth = true;
                  isLoading=false;
                  break;
                }
              default:
                {
                  getListComplaintSuccess = false;
                  errorMsg = (response as Error).msg;
                  isLoading=false;
                  break;
                }
            }
          }
      }
    } catch (error) {
      errorMsg = error.toString();
      getListComplaintSuccess = false;
      isLoading=false;
    }
  }
}
