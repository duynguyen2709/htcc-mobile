import 'package:mobx/mobx.dart';

part 'leaving_form_store.g.dart';

class LeavingFormStore = _LeavingFormStore with _$LeavingFormStore;

abstract class _LeavingFormStore with Store {
  @observable
  bool isBooking = true;

  @observable
  bool isLoading = false;

  @observable
  List<DateTime> listBooking = List<DateTime>();

  @observable
  Map<DateTime, List> events;

  init(){
    events = {
      DateTime(2020, 2, 1): ['New Year\'s Day'],
      DateTime(2020, 2, 2): ['New Year\'s Day'],
      DateTime(2020, 2, 6): ['Epiphany'],
      DateTime(2020, 2, 14): ['Valentine\'s Day'],
    };
  }
}