import 'package:mobx/mobx.dart';
import 'dart:developer';

part 'check_in_screen_store.g.dart';

class CheckInStore extends _CheckInStore with _$CheckInStore{
}

abstract class _CheckInStore with Store{
  @observable
  bool isLoading = false;

}