// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuickLoginStore on _QuickLoginStore, Store {
  final _$isLoadingAtom = Atom(name: '_QuickLoginStore.isLoading');

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

  final _$checkLoginAtom = Atom(name: '_QuickLoginStore.checkLogin');

  @override
  bool get checkLogin {
    _$checkLoginAtom.context.enforceReadPolicy(_$checkLoginAtom);
    _$checkLoginAtom.reportObserved();
    return super.checkLogin;
  }

  @override
  set checkLogin(bool value) {
    _$checkLoginAtom.context.conditionallyRunInAction(() {
      super.checkLogin = value;
      _$checkLoginAtom.reportChanged();
    }, _$checkLoginAtom, name: '${_$checkLoginAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_QuickLoginStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future login(String userName, String password, String companyId) {
    return _$loginAsyncAction
        .run(() => super.login(userName, password, companyId));
  }
}
