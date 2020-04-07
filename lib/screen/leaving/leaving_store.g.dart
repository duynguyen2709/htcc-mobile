// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaving_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LeavingStore on _LeavingStore, Store {
  final _$isLoadingAtom = Atom(name: '_LeavingStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$shouldRetryAtom = Atom(name: '_LeavingStore.shouldRetry');

  @override
  bool get shouldRetry {
    _$shouldRetryAtom.context.enforceReadPolicy(_$shouldRetryAtom);
    _$shouldRetryAtom.reportObserved();
    return super.shouldRetry;
  }

  @override
  set shouldRetry(bool value) {
    _$shouldRetryAtom.context.conditionallyRunInAction(() {
      super.shouldRetry = value;
      _$shouldRetryAtom.reportChanged();
    }, _$shouldRetryAtom, name: '${_$shouldRetryAtom.name}_set');
  }

  final _$eventsAtom = Atom(name: '_LeavingStore.events');

  @override
  Map<DateTime, List<dynamic>> get events {
    _$eventsAtom.context.enforceReadPolicy(_$eventsAtom);
    _$eventsAtom.reportObserved();
    return super.events;
  }

  @override
  set events(Map<DateTime, List<dynamic>> value) {
    _$eventsAtom.context.conditionallyRunInAction(() {
      super.events = value;
      _$eventsAtom.reportChanged();
    }, _$eventsAtom, name: '${_$eventsAtom.name}_set');
  }

  final _$errorMsgAtom = Atom(name: '_LeavingStore.errorMsg');

  @override
  String get errorMsg {
    _$errorMsgAtom.context.enforceReadPolicy(_$errorMsgAtom);
    _$errorMsgAtom.reportObserved();
    return super.errorMsg;
  }

  @override
  set errorMsg(String value) {
    _$errorMsgAtom.context.conditionallyRunInAction(() {
      super.errorMsg = value;
      _$errorMsgAtom.reportChanged();
    }, _$errorMsgAtom, name: '${_$errorMsgAtom.name}_set');
  }

  final _$leavingDataAtom = Atom(name: '_LeavingStore.leavingData');

  @override
  LeavingData get leavingData {
    _$leavingDataAtom.context.enforceReadPolicy(_$leavingDataAtom);
    _$leavingDataAtom.reportObserved();
    return super.leavingData;
  }

  @override
  set leavingData(LeavingData value) {
    _$leavingDataAtom.context.conditionallyRunInAction(() {
      super.leavingData = value;
      _$leavingDataAtom.reportChanged();
    }, _$leavingDataAtom, name: '${_$leavingDataAtom.name}_set');
  }

  final _$listRequestAtom = Atom(name: '_LeavingStore.listRequest');

  @override
  List<ListRequest> get listRequest {
    _$listRequestAtom.context.enforceReadPolicy(_$listRequestAtom);
    _$listRequestAtom.reportObserved();
    return super.listRequest;
  }

  @override
  set listRequest(List<ListRequest> value) {
    _$listRequestAtom.context.conditionallyRunInAction(() {
      super.listRequest = value;
      _$listRequestAtom.reportChanged();
    }, _$listRequestAtom, name: '${_$listRequestAtom.name}_set');
  }

  final _$dataMapAtom = Atom(name: '_LeavingStore.dataMap');

  @override
  Map<String, double> get dataMap {
    _$dataMapAtom.context.enforceReadPolicy(_$dataMapAtom);
    _$dataMapAtom.reportObserved();
    return super.dataMap;
  }

  @override
  set dataMap(Map<String, double> value) {
    _$dataMapAtom.context.conditionallyRunInAction(() {
      super.dataMap = value;
      _$dataMapAtom.reportChanged();
    }, _$dataMapAtom, name: '${_$dataMapAtom.name}_set');
  }

  final _$statusAtom = Atom(name: '_LeavingStore.status');

  @override
  Pair get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(Pair value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$yearAtom = Atom(name: '_LeavingStore.year');

  @override
  int get year {
    _$yearAtom.context.enforceReadPolicy(_$yearAtom);
    _$yearAtom.reportObserved();
    return super.year;
  }

  @override
  set year(int value) {
    _$yearAtom.context.conditionallyRunInAction(() {
      super.year = value;
      _$yearAtom.reportChanged();
    }, _$yearAtom, name: '${_$yearAtom.name}_set');
  }

  final _$loadDataAsyncAction = AsyncAction('loadData');

  @override
  Future loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  final _$_LeavingStoreActionController =
      ActionController(name: '_LeavingStore');

  @override
  dynamic filter(Pair pair) {
    final _$actionInfo = _$_LeavingStoreActionController.startAction();
    try {
      return super.filter(pair);
    } finally {
      _$_LeavingStoreActionController.endAction(_$actionInfo);
    }
  }
}
