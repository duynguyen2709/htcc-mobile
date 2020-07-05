// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_shift_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PersonalShiftStore on _PersonalShiftStore, Store {
  final _$isLoadingAtom = Atom(name: '_PersonalShiftStore.isLoading');

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

  final _$isSuccessAtom = Atom(name: '_PersonalShiftStore.isSuccess');

  @override
  bool get isSuccess {
    _$isSuccessAtom.context.enforceReadPolicy(_$isSuccessAtom);
    _$isSuccessAtom.reportObserved();
    return super.isSuccess;
  }

  @override
  set isSuccess(bool value) {
    _$isSuccessAtom.context.conditionallyRunInAction(() {
      super.isSuccess = value;
      _$isSuccessAtom.reportChanged();
    }, _$isSuccessAtom, name: '${_$isSuccessAtom.name}_set');
  }

  final _$resultAtom = Atom(name: '_PersonalShiftStore.result');

  @override
  List<ShiftArrangement> get result {
    _$resultAtom.context.enforceReadPolicy(_$resultAtom);
    _$resultAtom.reportObserved();
    return super.result;
  }

  @override
  set result(List<ShiftArrangement> value) {
    _$resultAtom.context.conditionallyRunInAction(() {
      super.result = value;
      _$resultAtom.reportChanged();
    }, _$resultAtom, name: '${_$resultAtom.name}_set');
  }

  final _$msgAtom = Atom(name: '_PersonalShiftStore.msg');

  @override
  String get msg {
    _$msgAtom.context.enforceReadPolicy(_$msgAtom);
    _$msgAtom.reportObserved();
    return super.msg;
  }

  @override
  set msg(String value) {
    _$msgAtom.context.conditionallyRunInAction(() {
      super.msg = value;
      _$msgAtom.reportChanged();
    }, _$msgAtom, name: '${_$msgAtom.name}_set');
  }

  final _$getPersonalShiftAsyncAction = AsyncAction('getPersonalShift');

  @override
  Future getPersonalShift(String month) {
    return _$getPersonalShiftAsyncAction
        .run(() => super.getPersonalShift(month));
  }
}
