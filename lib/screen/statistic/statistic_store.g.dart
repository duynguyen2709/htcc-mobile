// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StatisticStore on _StatisticStore, Store {
  final _$isLoadingAtom = Atom(name: '_StatisticStore.isLoading');

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

  final _$isSuccessAtom = Atom(name: '_StatisticStore.isSuccess');

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

  final _$resultAtom = Atom(name: '_StatisticStore.result');

  @override
  StatisticResponse get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(StatisticResponse value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  final _$msgAtom = Atom(name: '_StatisticStore.msg');

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

  final _$getStatisticInfoAsyncAction =
      AsyncAction('_StatisticStore.getStatisticInfo');

  @override
  Future getStatisticInfo(GetStatisticParam param) {
    return _$getStatisticInfoAsyncAction
        .run(() => super.getStatisticInfo(param));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isSuccess: ${isSuccess},
result: ${result},
msg: ${msg}
    ''';
  }
}
