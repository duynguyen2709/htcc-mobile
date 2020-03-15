// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaving_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LeavingStore on _LeavingStore, Store {
  final _$isLoadingAtom = Atom(name: '_LeavingStore.isLoading');

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

  final _$shouldRetryAtom = Atom(name: '_LeavingStore.shouldRetry');

  @override
  bool get shouldRetry {
    _$shouldRetryAtom.context.enforceReadPolicy(_$shouldRetryAtom);
    _$shouldRetryAtom.reportObserved();
    return super.shouldRetry;
  }

  @override
  set shouldRetry(bool value) {
    _$shouldRetryAtom.context.conditionallyRunInAction(() {
      super.shouldRetry = value;
      _$shouldRetryAtom.reportChanged();
    }, _$shouldRetryAtom, name: '${_$shouldRetryAtom.name}_set');
  }

  final _$eventsAtom = Atom(name: '_LeavingStore.events');

  @override
  Map<DateTime, List<dynamic>> get events {
    _$eventsAtom.context.enforceReadPolicy(_$eventsAtom);
    _$eventsAtom.reportObserved();
    return super.events;
  }

  @override
  set events(Map<DateTime, List<dynamic>> value) {
    _$eventsAtom.context.conditionallyRunInAction(() {
      super.events = value;
      _$eventsAtom.reportChanged();
    }, _$eventsAtom, name: '${_$eventsAtom.name}_set');
  }

  final _$infoLeavingAtom = Atom(name: '_LeavingStore.infoLeaving');

  @override
  InfoLeaving get infoLeaving {
    _$infoLeavingAtom.context.enforceReadPolicy(_$infoLeavingAtom);
    _$infoLeavingAtom.reportObserved();
    return super.infoLeaving;
  }

  @override
  set infoLeaving(InfoLeaving value) {
    _$infoLeavingAtom.context.conditionallyRunInAction(() {
      super.infoLeaving = value;
      _$infoLeavingAtom.reportChanged();
    }, _$infoLeavingAtom, name: '${_$infoLeavingAtom.name}_set');
  }

  final _$dataMapAtom = Atom(name: '_LeavingStore.dataMap');

  @override
  Map<String, double> get dataMap {
    _$dataMapAtom.context.enforceReadPolicy(_$dataMapAtom);
    _$dataMapAtom.reportObserved();
    return super.dataMap;
  }

  @override
  set dataMap(Map<String, double> value) {
    _$dataMapAtom.context.conditionallyRunInAction(() {
      super.dataMap = value;
      _$dataMapAtom.reportChanged();
    }, _$dataMapAtom, name: '${_$dataMapAtom.name}_set');
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},shouldRetry: ${shouldRetry.toString()},events: ${events.toString()},infoLeaving: ${infoLeaving.toString()},dataMap: ${dataMap.toString()}';
    return '{$string}';
  }
}
