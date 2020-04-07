import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'detail_leaving_store.g.dart';

class DetailLeavingStore = _DetailLeavingStore with _$DetailLeavingStore;

abstract class _DetailLeavingStore with Store {
  @observable
  bool isLoading = false;

  @observable
  String msg;

  @action
  submit(FormLeaving formLeaving) async {
    isLoading = true;
    msg = null;
    try {
      formLeaving.detail = formLeaving.detail.where((value) => value.isCheck).toList();
      if (formLeaving.detail.length > 0) {
        var response = await Injector.leavingRepository.submit(formLeaving);
        isLoading = false;
        switch (response.runtimeType) {
          case Success:
            {
              msg = "Thành công";
              break;
            }
          case Error:
            {
              switch ((response as Error).status) {
                case Status.ERROR_NETWORK:
                  {
                    msg = "Lỗi kết nối";
                    break;
                  }
                case Status.ERROR_AUTHENTICATE:
                  {
                    msg = "Lỗi xác thực";
                    break;
                  }
                default:
                  {
                    msg = Constants.UPDATE_FAIL;
                    break;
                  }
              }
            }
        }
      } else {
        msg = "Chưa chọn ngày nghỉ";
      }
    } catch (error) {
      isLoading = false;
      msg = Constants.UPDATE_FAIL;
    }
  }
}
