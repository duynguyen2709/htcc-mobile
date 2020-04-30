// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaving_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LeavingFormStore on _LeavingFormStore, Store {
  final _$isLoadingSubmitFormAtom =
      Atom(name: '_LeavingFormStore.isLoadingSubmitForm');

  @override
  bool get isLoadingSubmitForm {
    _$isLoadingSubmitFormAtom.context
        .enforceReadPolicy(_$isLoadingSubmitFormAtom);
    _$isLoadingSubmitFormAtom.reportObserved();
    return super.isLoadingSubmitForm;
  }

  @override
  set isLoadingSubmitForm(bool value) {
    _$isLoadingSubmitFormAtom.context.conditionallyRunInAction(() {
      super.isLoadingSubmitForm = value;
      _$isLoadingSubmitFormAtom.reportChanged();
    }, _$isLoadingSubmitFormAtom,
        name: '${_$isLoadingSubmitFormAtom.name}_set');
  }

  final _$msgAtom = Atom(name: '_LeavingFormStore.msg');

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

  final _$isSubmitSuccessAtom = Atom(name: '_LeavingFormStore.isSubmitSuccess');

  @override
  bool get isSubmitSuccess {
    _$isSubmitSuccessAtom.context.enforceReadPolicy(_$isSubmitSuccessAtom);
    _$isSubmitSuccessAtom.reportObserved();
    return super.isSubmitSuccess;
  }

  @override
  set isSubmitSuccess(bool value) {
    _$isSubmitSuccessAtom.context.conditionallyRunInAction(() {
      super.isSubmitSuccess = value;
      _$isSubmitSuccessAtom.reportChanged();
    }, _$isSubmitSuccessAtom, name: '${_$isSubmitSuccessAtom.name}_set');
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

  final _$errAuthAtom = Atom(name: '_LeavingFormStore.errAuth');

  @override
  bool get errAuth {
    _$errAuthAtom.context.enforceReadPolicy(_$errAuthAtom);
    _$errAuthAtom.reportObserved();
    return super.errAuth;
  }

  @override
  set errAuth(bool value) {
    _$errAuthAtom.context.conditionallyRunInAction(() {
      super.errAuth = value;
      _$errAuthAtom.reportChanged();
    }, _$errAuthAtom, name: '${_$errAuthAtom.name}_set');
  }

  final _$submitAsyncAction = AsyncAction('submit');

  @override
  Future submit(FormLeaving formLeaving) {
    return _$submitAsyncAction.run(() => super.submit(formLeaving));
  }

  @override
  String toString() {
    final string =
        'isLoadingSubmitForm: ${isLoadingSubmitForm.toString()},msg: ${msg.toString()},isSubmitSuccess: ${isSubmitSuccess.toString()},events: ${events.toString()},errAuth: ${errAuth.toString()}';
    return '{$string}';
  }
}
