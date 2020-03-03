// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaving_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LeavingFormStore on _LeavingFormStore, Store {
  final _$isBookingAtom = Atom(name: '_LeavingFormStore.isBooking');

  @override
  bool get isBooking {
    _$isBookingAtom.context.enforceReadPolicy(_$isBookingAtom);
    _$isBookingAtom.reportObserved();
    return super.isBooking;
  }

  @override
  set isBooking(bool value) {
    _$isBookingAtom.context.conditionallyRunInAction(() {
      super.isBooking = value;
      _$isBookingAtom.reportChanged();
    }, _$isBookingAtom, name: '${_$isBookingAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_LeavingFormStore.isLoading');

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

  final _$listBookingAtom = Atom(name: '_LeavingFormStore.listBooking');

  @override
  List<DateTime> get listBooking {
    _$listBookingAtom.context.enforceReadPolicy(_$listBookingAtom);
    _$listBookingAtom.reportObserved();
    return super.listBooking;
  }

  @override
  set listBooking(List<DateTime> value) {
    _$listBookingAtom.context.conditionallyRunInAction(() {
      super.listBooking = value;
      _$listBookingAtom.reportChanged();
    }, _$listBookingAtom, name: '${_$listBookingAtom.name}_set');
  }

  final _$eventsAtom = Atom(name: '_LeavingFormStore.events');

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
}
