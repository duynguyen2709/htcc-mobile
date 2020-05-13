import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'main_screen_store.g.dart';

const SIZE = 2;

class MainScreenStore = _MainScreenStore with _$MainScreenStore;

abstract class _MainScreenStore with Store {
  @observable
  int number = 0;

  @action
  getCountNotification() async {
    try {
      number = await Injector.mainRepository.getCountNotification();
    } catch (error) {
      number = 0;
    }
  }

  @action
  setNumber(int type) {
    if (type != 0)
      number = number - 1;
    else
      number = 0;
  }
}
