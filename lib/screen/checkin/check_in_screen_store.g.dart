// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CheckInStore on _CheckInStore, Store {
  final _$isLoadingAtom = Atom(name: '_CheckInStore.isLoading');

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

  final _$getInfoCheckInSuccessAtom =
      Atom(name: '_CheckInStore.getInfoCheckInSuccess');

  @override
  bool get getInfoCheckInSuccess {
    _$getInfoCheckInSuccessAtom.context
        .enforceReadPolicy(_$getInfoCheckInSuccessAtom);
    _$getInfoCheckInSuccessAtom.reportObserved();
    return super.getInfoCheckInSuccess;
  }

  @override
  set getInfoCheckInSuccess(bool value) {
    _$getInfoCheckInSuccessAtom.context.conditionallyRunInAction(() {
      super.getInfoCheckInSuccess = value;
      _$getInfoCheckInSuccessAtom.reportChanged();
    }, _$getInfoCheckInSuccessAtom,
        name: '${_$getInfoCheckInSuccessAtom.name}_set');
  }

  final _$checkInSuccessAtom = Atom(name: '_CheckInStore.checkInSuccess');

  @override
  bool get checkInSuccess {
    _$checkInSuccessAtom.context.enforceReadPolicy(_$checkInSuccessAtom);
    _$checkInSuccessAtom.reportObserved();
    return super.checkInSuccess;
  }

  @override
  set checkInSuccess(bool value) {
    _$checkInSuccessAtom.context.conditionallyRunInAction(() {
      super.checkInSuccess = value;
      _$checkInSuccessAtom.reportChanged();
    }, _$checkInSuccessAtom, name: '${_$checkInSuccessAtom.name}_set');
  }

  final _$errorMsgAtom = Atom(name: '_CheckInStore.errorMsg');

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

  final _$errorAuthAtom = Atom(name: '_CheckInStore.errorAuth');

  @override
  bool get errorAuth {
    _$errorAuthAtom.context.enforceReadPolicy(_$errorAuthAtom);
    _$errorAuthAtom.reportObserved();
    return super.errorAuth;
  }

  @override
  set errorAuth(bool value) {
    _$errorAuthAtom.context.conditionallyRunInAction(() {
      super.errorAuth = value;
      _$errorAuthAtom.reportChanged();
    }, _$errorAuthAtom, name: '${_$errorAuthAtom.name}_set');
  }

  final _$getCheckInInfoAsyncAction = AsyncAction('getCheckInInfo');

  @override
  Future getCheckInInfo(String companyId, String username, String date) {
    return _$getCheckInInfoAsyncAction
        .run(() => super.getCheckInInfo(companyId, username, date));
  }

  final _$checkInAsyncAction = AsyncAction('checkIn');

  @override
  Future checkIn(CheckInParam param) {
    return _$checkInAsyncAction.run(() => super.checkIn(param));
  }
}
