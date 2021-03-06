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

  final _$listEventAtom = Atom(name: '_LeavingStore.listEvent');

  @override
  Map<DateTime, List<EventDetail>> get listEvent {
    _$listEventAtom.context.enforceReadPolicy(_$listEventAtom);
    _$listEventAtom.reportObserved();
    return super.listEvent;
  }

  @override
  set listEvent(Map<DateTime, List<EventDetail>> value) {
    _$listEventAtom.context.conditionallyRunInAction(() {
      super.listEvent = value;
      _$listEventAtom.reportChanged();
    }, _$listEventAtom, name: '${_$listEventAtom.name}_set');
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

  final _$isSubmitSuccessAtom = Atom(name: '_LeavingStore.isSubmitSuccess');

  @override
  bool get isSubmitSuccess {
    _$isSubmitSuccessAtom.context.enforceReadPolicy(_$isSubmitSuccessAtom);
    _$isSubmitSuccessAtom.reportObserved();
    return super.isSubmitSuccess;
  }

  @override
  set isSubmitSuccess(bool value) {
    _$isSubmitSuccessAtom.context.conditionallyRunInAction(() {
      super.isSubmitSuccess = value;
      _$isSubmitSuccessAtom.reportChanged();
    }, _$isSubmitSuccessAtom, name: '${_$isSubmitSuccessAtom.name}_set');
  }

  final _$isLoadingSubmitFormAtom =
      Atom(name: '_LeavingStore.isLoadingSubmitForm');

  @override
  bool get isLoadingSubmitForm {
    _$isLoadingSubmitFormAtom.context
        .enforceReadPolicy(_$isLoadingSubmitFormAtom);
    _$isLoadingSubmitFormAtom.reportObserved();
    return super.isLoadingSubmitForm;
  }

  @override
  set isLoadingSubmitForm(bool value) {
    _$isLoadingSubmitFormAtom.context.conditionallyRunInAction(() {
      super.isLoadingSubmitForm = value;
      _$isLoadingSubmitFormAtom.reportChanged();
    }, _$isLoadingSubmitFormAtom,
        name: '${_$isLoadingSubmitFormAtom.name}_set');
  }

  final _$isLoadingCancelAtom = Atom(name: '_LeavingStore.isLoadingCancel');

  @override
  bool get isLoadingCancel {
    _$isLoadingCancelAtom.context.enforceReadPolicy(_$isLoadingCancelAtom);
    _$isLoadingCancelAtom.reportObserved();
    return super.isLoadingCancel;
  }

  @override
  set isLoadingCancel(bool value) {
    _$isLoadingCancelAtom.context.conditionallyRunInAction(() {
      super.isLoadingCancel = value;
      _$isLoadingCancelAtom.reportChanged();
    }, _$isLoadingCancelAtom, name: '${_$isLoadingCancelAtom.name}_set');
  }

  final _$isCancelSuccessAtom = Atom(name: '_LeavingStore.isCancelSuccess');

  @override
  bool get isCancelSuccess {
    _$isCancelSuccessAtom.context.enforceReadPolicy(_$isCancelSuccessAtom);
    _$isCancelSuccessAtom.reportObserved();
    return super.isCancelSuccess;
  }

  @override
  set isCancelSuccess(bool value) {
    _$isCancelSuccessAtom.context.conditionallyRunInAction(() {
      super.isCancelSuccess = value;
      _$isCancelSuccessAtom.reportChanged();
    }, _$isCancelSuccessAtom, name: '${_$isCancelSuccessAtom.name}_set');
  }

  final _$errAuthAtom = Atom(name: '_LeavingStore.errAuth');

  @override
  bool get errAuth {
    _$errAuthAtom.context.enforceReadPolicy(_$errAuthAtom);
    _$errAuthAtom.reportObserved();
    return super.errAuth;
  }

  @override
  set errAuth(bool value) {
    _$errAuthAtom.context.conditionallyRunInAction(() {
      super.errAuth = value;
      _$errAuthAtom.reportChanged();
    }, _$errAuthAtom, name: '${_$errAuthAtom.name}_set');
  }

  final _$loadDataAsyncAction = AsyncAction('loadData');

  @override
  Future loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  final _$submitAsyncAction = AsyncAction('submit');

  @override
  Future submit(FormLeaving formLeaving) {
    return _$submitAsyncAction.run(() => super.submit(formLeaving));
  }

  final _$cancelAsyncAction = AsyncAction('cancel');

  @override
  Future cancel(String leavingRequestId, String date) {
    return _$cancelAsyncAction.run(() => super.cancel(leavingRequestId, date));
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
