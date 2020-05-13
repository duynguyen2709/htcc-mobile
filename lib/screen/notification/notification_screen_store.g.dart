// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationScreenStore on _NotificationScreenStore, Store {
  final _$isLoadingAtom = Atom(name: '_NotificationScreenStore.isLoading');

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

  final _$listAtom = Atom(name: '_NotificationScreenStore.list');

  @override
  List<NotificationPush> get list {
    _$listAtom.context.enforceReadPolicy(_$listAtom);
    _$listAtom.reportObserved();
    return super.list;
  }

  @override
  set list(List<NotificationPush> value) {
    _$listAtom.context.conditionallyRunInAction(() {
      super.list = value;
      _$listAtom.reportChanged();
    }, _$listAtom, name: '${_$listAtom.name}_set');
  }

  final _$msgAtom = Atom(name: '_NotificationScreenStore.msg');

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

  final _$msgLoadMoreAtom = Atom(name: '_NotificationScreenStore.msgLoadMore');

  @override
  String get msgLoadMore {
    _$msgLoadMoreAtom.context.enforceReadPolicy(_$msgLoadMoreAtom);
    _$msgLoadMoreAtom.reportObserved();
    return super.msgLoadMore;
  }

  @override
  set msgLoadMore(String value) {
    _$msgLoadMoreAtom.context.conditionallyRunInAction(() {
      super.msgLoadMore = value;
      _$msgLoadMoreAtom.reportChanged();
    }, _$msgLoadMoreAtom, name: '${_$msgLoadMoreAtom.name}_set');
  }

  final _$initAsyncAction = AsyncAction('init');

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$loadNextPageAsyncAction = AsyncAction('loadNextPage');

  @override
  Future loadNextPage() {
    return _$loadNextPageAsyncAction.run(() => super.loadNextPage());
  }

  final _$_NotificationScreenStoreActionController =
      ActionController(name: '_NotificationScreenStore');

  @override
  dynamic updateStatusNotification(String id, int type) {
    final _$actionInfo =
        _$_NotificationScreenStoreActionController.startAction();
    try {
      return super.updateStatusNotification(id, type);
    } finally {
      _$_NotificationScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},list: ${list.toString()},msg: ${msg.toString()},msgLoadMore: ${msgLoadMore.toString()}';
    return '{$string}';
  }
}
