// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShiftStore on _ShiftStore, Store {
  final _$isLoadingAtom = Atom(name: '_ShiftStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isSuccessAtom = Atom(name: '_ShiftStore.isSuccess');

  @override
  bool get isSuccess {
    _$isSuccessAtom.reportRead();
    return super.isSuccess;
  }

  @override
  set isSuccess(bool value) {
    _$isSuccessAtom.reportWrite(value, super.isSuccess, () {
      super.isSuccess = value;
    });
  }

  final _$resultAtom = Atom(name: '_ShiftStore.result');

  @override
  WorkingDayResponse get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(WorkingDayResponse value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  final _$personalShiftResultAtom =
      Atom(name: '_ShiftStore.personalShiftResult');

  @override
  List<ShiftArrangement> get personalShiftResult {
    _$personalShiftResultAtom.reportRead();
    return super.personalShiftResult;
  }

  @override
  set personalShiftResult(List<ShiftArrangement> value) {
    _$personalShiftResultAtom.reportWrite(value, super.personalShiftResult, () {
      super.personalShiftResult = value;
    });
  }

  final _$msgAtom = Atom(name: '_ShiftStore.msg');

  @override
  String get msg {
    _$msgAtom.reportRead();
    return super.msg;
  }

  @override
  set msg(String value) {
    _$msgAtom.reportWrite(value, super.msg, () {
      super.msg = value;
    });
  }

  final _$getCompanyWorkingDaysAsyncAction =
      AsyncAction('_ShiftStore.getCompanyWorkingDays');

  @override
  Future getCompanyWorkingDays(String month) {
    return _$getCompanyWorkingDaysAsyncAction
        .run(() => super.getCompanyWorkingDays(month));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isSuccess: ${isSuccess},
result: ${result},
personalShiftResult: ${personalShiftResult},
msg: ${msg}
    ''';
  }
}
