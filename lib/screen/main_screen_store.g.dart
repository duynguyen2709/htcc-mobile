// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainScreenStore on _MainScreenStore, Store {
  final _$numberAtom = Atom(name: '_MainScreenStore.number');

  @override
  int get number {
    _$numberAtom.context.enforceReadPolicy(_$numberAtom);
    _$numberAtom.reportObserved();
    return super.number;
  }

  @override
  set number(int value) {
    _$numberAtom.context.conditionallyRunInAction(() {
      super.number = value;
      _$numberAtom.reportChanged();
    }, _$numberAtom, name: '${_$numberAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_MainScreenStore.isLoading');

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

  final _$getCountNotificationAsyncAction = AsyncAction('getCountNotification');

  @override
  Future getCountNotification() {
    return _$getCountNotificationAsyncAction
        .run(() => super.getCountNotification());
  }

  final _$_MainScreenStoreActionController =
      ActionController(name: '_MainScreenStore');

  @override
  dynamic setNumber(int type) {
    final _$actionInfo = _$_MainScreenStoreActionController.startAction();
    try {
      return super.setNumber(type);
    } finally {
      _$_MainScreenStoreActionController.endAction(_$actionInfo);
    }
  }
}
