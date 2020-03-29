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

  final _$accountAtom = Atom(name: '_AccountScreenStore.account');

  @override
  User get account {
    _$accountAtom.context.enforceReadPolicy(_$accountAtom);
    _$accountAtom.reportObserved();
    return super.account;
  }

  @override
  set account(User value) {
    _$accountAtom.context.conditionallyRunInAction(() {
      super.account = value;
      _$accountAtom.reportChanged();
    }, _$accountAtom, name: '${_$accountAtom.name}_set');
  }

  final _$isConfigAtom = Atom(name: '_AccountScreenStore.isConfig');

  @override
  bool get isConfig {
    _$isConfigAtom.context.enforceReadPolicy(_$isConfigAtom);
    _$isConfigAtom.reportObserved();
    return super.isConfig;
  }

  @override
  set isConfig(bool value) {
    _$isConfigAtom.context.conditionallyRunInAction(() {
      super.isConfig = value;
      _$isConfigAtom.reportChanged();
    }, _$isConfigAtom, name: '${_$isConfigAtom.name}_set');
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

  final _$errorAuthenticateAtom =
      Atom(name: '_AccountScreenStore.errorAuthenticate');

  @override
  bool get errorAuthenticate {
    _$errorAuthenticateAtom.context.enforceReadPolicy(_$errorAuthenticateAtom);
    _$errorAuthenticateAtom.reportObserved();
    return super.errorAuthenticate;
  }

  @override
  set errorAuthenticate(bool value) {
    _$errorAuthenticateAtom.context.conditionallyRunInAction(() {
      super.errorAuthenticate = value;
      _$errorAuthenticateAtom.reportChanged();
    }, _$errorAuthenticateAtom, name: '${_$errorAuthenticateAtom.name}_set');
  }

  final _$errorNetworkAtom = Atom(name: '_AccountScreenStore.errorNetwork');

  @override
  bool get errorNetwork {
    _$errorNetworkAtom.context.enforceReadPolicy(_$errorNetworkAtom);
    _$errorNetworkAtom.reportObserved();
    return super.errorNetwork;
  }

  @override
  set errorNetwork(bool value) {
    _$errorNetworkAtom.context.conditionallyRunInAction(() {
      super.errorNetwork = value;
      _$errorNetworkAtom.reportChanged();
    }, _$errorNetworkAtom, name: '${_$errorNetworkAtom.name}_set');
  }

  final _$errorUpdateAtom = Atom(name: '_AccountScreenStore.errorUpdate');

  @override
  bool get errorUpdate {
    _$errorUpdateAtom.context.enforceReadPolicy(_$errorUpdateAtom);
    _$errorUpdateAtom.reportObserved();
    return super.errorUpdate;
  }

  @override
  set errorUpdate(bool value) {
    _$errorUpdateAtom.context.conditionallyRunInAction(() {
      super.errorUpdate = value;
      _$errorUpdateAtom.reportChanged();
    }, _$errorUpdateAtom, name: '${_$errorUpdateAtom.name}_set');
  }

  final _$messageAtom = Atom(name: '_AccountScreenStore.message');

  @override
  String get message {
    _$messageAtom.context.enforceReadPolicy(_$messageAtom);
    _$messageAtom.reportObserved();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.context.conditionallyRunInAction(() {
      super.message = value;
      _$messageAtom.reportChanged();
    }, _$messageAtom, name: '${_$messageAtom.name}_set');
  }

  final _$imageAtom = Atom(name: '_AccountScreenStore.image');

  @override
  File get image {
    _$imageAtom.context.enforceReadPolicy(_$imageAtom);
    _$imageAtom.reportObserved();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.context.conditionallyRunInAction(() {
      super.image = value;
      _$imageAtom.reportChanged();
    }, _$imageAtom, name: '${_$imageAtom.name}_set');
  }

  final _$getAccountAsyncAction = AsyncAction('getAccount');

  @override
  Future getAccount() {
    return _$getAccountAsyncAction.run(() => super.getAccount());
  }

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$updateAccountAsyncAction = AsyncAction('updateAccount');

  @override
  Future updateAccount() {
    return _$updateAccountAsyncAction.run(() => super.updateAccount());
  }
}
