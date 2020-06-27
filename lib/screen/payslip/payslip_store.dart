import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/payslip.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'payslip_store.g.dart';

class PaySlipStore = _PaySlipStore with _$PaySlipStore;

abstract class _PaySlipStore with Store {
  @observable
  bool isLoading = false;

  @observable
  List<Payslip> listPayslip = [];

  @observable
  String msg = '';

  @action
  getPayslip(String time) async {
    try {
      isLoading = true;
      listPayslip = null;
      msg = '';
      var result = await Injector.payslipRepository.getPayslip(time);
      switch (result.runtimeType) {
        case Success:
          {
            listPayslip = (result as Success).data;
            break;
          }
        case Error:
          {
            msg = (result as Error).msg;
            break;
          }
        default:
          {}
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }
}
