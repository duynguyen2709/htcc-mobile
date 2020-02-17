// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountScreenStore on _AccountScreenStore, Store {
  final _$isLoadingAtom = Atom(name: '_AccountScreenStore.isLoading');

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

  final _$accountDataAtom = Atom(name: '_AccountScreenStore.accountData');

  @override
  AccountData get accountData {
    _$accountDataAtom.context.enforceReadPolicy(_$accountDataAtom);
    _$accountDataAtom.reportObserved();
    return super.accountData;
  }

  @override
  set accountData(AccountData value) {
    _$accountDataAtom.context.conditionallyRunInAction(() {
      super.accountData = value;
      _$accountDataAtom.reportChanged();
    }, _$accountDataAtom, name: '${_$accountDataAtom.name}_set');
  }

  final _$editAtom = Atom(name: '_AccountScreenStore.edit');

  @override
  bool get edit {
    _$editAtom.context.enforceReadPolicy(_$editAtom);
    _$editAtom.reportObserved();
    return super.edit;
  }

  @override
  set edit(bool value) {
    _$editAtom.context.conditionallyRunInAction(() {
      super.edit = value;
      _$editAtom.reportChanged();
    }, _$editAtom, name: '${_$editAtom.name}_set');
  }

  final _$errorAtom = Atom(name: '_AccountScreenStore.error');

  @override
  bool get error {
    _$errorAtom.context.enforceReadPolicy(_$errorAtom);
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.context.conditionallyRunInAction(() {
      super.error = value;
      _$errorAtom.reportChanged();
    }, _$errorAtom, name: '${_$errorAtom.name}_set');
  }

  final _$getAccountAsyncAction = AsyncAction('getAccount');

  @override
  Future getAccount() {
    return _$getAccountAsyncAction.run(() => super.getAccount());
  }
}
