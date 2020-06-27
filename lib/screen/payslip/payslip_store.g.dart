// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PaySlipStore on _PaySlipStore, Store {
  final _$isLoadingAtom = Atom(name: '_PaySlipStore.isLoading');

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

  final _$listPayslipAtom = Atom(name: '_PaySlipStore.listPayslip');

  @override
  List<Payslip> get listPayslip {
    _$listPayslipAtom.context.enforceReadPolicy(_$listPayslipAtom);
    _$listPayslipAtom.reportObserved();
    return super.listPayslip;
  }

  @override
  set listPayslip(List<Payslip> value) {
    _$listPayslipAtom.context.conditionallyRunInAction(() {
      super.listPayslip = value;
      _$listPayslipAtom.reportChanged();
    }, _$listPayslipAtom, name: '${_$listPayslipAtom.name}_set');
  }

  final _$msgAtom = Atom(name: '_PaySlipStore.msg');

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

  final _$getPayslipAsyncAction = AsyncAction('getPayslip');

  @override
  Future getPayslip(String time) {
    return _$getPayslipAsyncAction.run(() => super.getPayslip(time));
  }
}
