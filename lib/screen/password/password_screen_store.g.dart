// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PasswordScreenStore on _PasswordScreenStore, Store {
  final _$isLoadingAtom = Atom(name: '_PasswordScreenStore.isLoading');

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

  final _$isSuccessAtom = Atom(name: '_PasswordScreenStore.isSuccess');

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

  final _$errorMessageAtom = Atom(name: '_PasswordScreenStore.errorMessage');

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

  final _$changePasswordAsyncAction = AsyncAction('changePassword');

  @override
  Future changePassword(String userName, String newPassword, String oldPassword,
      String companyId) {
    return _$changePasswordAsyncAction.run(() =>
        super.changePassword(userName, newPassword, oldPassword, companyId));
  }
}
