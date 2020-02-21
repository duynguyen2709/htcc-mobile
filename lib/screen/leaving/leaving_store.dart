import 'package:mobx/mobx.dart';

part 'leaving_store.g.dart';

class LeavingStore = _LeavingStore with _$LeavingStore;

abstract class _LeavingStore with Store {
  @observable
  bool isLoading = false;

  @observable
  bool shouldRetry = false;

  @observable
  Map<DateTime, List> events;

  @observable
  InfoLeaving infoLeaving = InfoLeaving();

  @observable
  Map<String, double> dataMap = new Map();

  init() {
    dataMap.putIfAbsent("Flutter", () => 5);
    dataMap.putIfAbsent("React", () => 3);
    dataMap.putIfAbsent("Xamarin", () => 2);
    dataMap.putIfAbsent("Ionic", () => 2);
  }
}

class InfoLeaving {}
