import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/screen.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_screen_store.g.dart';

const SIZE = 2;

class MainScreenStore = _MainScreenStore with _$MainScreenStore;

abstract class _MainScreenStore with Store {
  @observable
  int number = 0;

  @observable
  bool isLoading = false;

  @action
  getCountNotification() async {
    try {
      isLoading = true;
      number = await Injector.mainRepository.getCountNotification();
      isLoading = false;
    } catch (error) {
      number = 0;
      isLoading = false;
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
