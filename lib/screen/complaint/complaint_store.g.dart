// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ComplaintStore on _ComplaintStore, Store {
  final _$isLoadingAtom = Atom(name: '_ComplaintStore.isLoading');

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

  final _$postComplaintSuccessAtom =
      Atom(name: '_ComplaintStore.postComplaintSuccess');

  @override
  bool get postComplaintSuccess {
    _$postComplaintSuccessAtom.context
        .enforceReadPolicy(_$postComplaintSuccessAtom);
    _$postComplaintSuccessAtom.reportObserved();
    return super.postComplaintSuccess;
  }

  @override
  set postComplaintSuccess(bool value) {
    _$postComplaintSuccessAtom.context.conditionallyRunInAction(() {
      super.postComplaintSuccess = value;
      _$postComplaintSuccessAtom.reportChanged();
    }, _$postComplaintSuccessAtom,
        name: '${_$postComplaintSuccessAtom.name}_set');
  }

  final _$getListComplaintSuccessAtom =
      Atom(name: '_ComplaintStore.getListComplaintSuccess');

  @override
  bool get getListComplaintSuccess {
    _$getListComplaintSuccessAtom.context
        .enforceReadPolicy(_$getListComplaintSuccessAtom);
    _$getListComplaintSuccessAtom.reportObserved();
    return super.getListComplaintSuccess;
  }

  @override
  set getListComplaintSuccess(bool value) {
    _$getListComplaintSuccessAtom.context.conditionallyRunInAction(() {
      super.getListComplaintSuccess = value;
      _$getListComplaintSuccessAtom.reportChanged();
    }, _$getListComplaintSuccessAtom,
        name: '${_$getListComplaintSuccessAtom.name}_set');
  }

  final _$listComplaintAtom = Atom(name: '_ComplaintStore.listComplaint');

  @override
  List<Complaint> get listComplaint {
    _$listComplaintAtom.context.enforceReadPolicy(_$listComplaintAtom);
    _$listComplaintAtom.reportObserved();
    return super.listComplaint;
  }

  @override
  set listComplaint(List<Complaint> value) {
    _$listComplaintAtom.context.conditionallyRunInAction(() {
      super.listComplaint = value;
      _$listComplaintAtom.reportChanged();
    }, _$listComplaintAtom, name: '${_$listComplaintAtom.name}_set');
  }

  final _$errorAuthAtom = Atom(name: '_ComplaintStore.errorAuth');

  @override
  bool get errorAuth {
    _$errorAuthAtom.context.enforceReadPolicy(_$errorAuthAtom);
    _$errorAuthAtom.reportObserved();
    return super.errorAuth;
  }

  @override
  set errorAuth(bool value) {
    _$errorAuthAtom.context.conditionallyRunInAction(() {
      super.errorAuth = value;
      _$errorAuthAtom.reportChanged();
    }, _$errorAuthAtom, name: '${_$errorAuthAtom.name}_set');
  }

  final _$errorMsgAtom = Atom(name: '_ComplaintStore.errorMsg');

  @override
  String get errorMsg {
    _$errorMsgAtom.context.enforceReadPolicy(_$errorMsgAtom);
    _$errorMsgAtom.reportObserved();
    return super.errorMsg;
  }

  @override
  set errorMsg(String value) {
    _$errorMsgAtom.context.conditionallyRunInAction(() {
      super.errorMsg = value;
      _$errorMsgAtom.reportChanged();
    }, _$errorMsgAtom, name: '${_$errorMsgAtom.name}_set');
  }

  final _$postComplaintAsyncAction = AsyncAction('postComplaint');

  @override
  Future postComplaint(CreateComplaintParam param) {
    return _$postComplaintAsyncAction.run(() => super.postComplaint(param));
  }

  final _$getComplaintAsyncAction = AsyncAction('getComplaint');

  @override
  Future getComplaint(DateTime month) {
    return _$getComplaintAsyncAction.run(() => super.getComplaint(month));
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},postComplaintSuccess: ${postComplaintSuccess.toString()},getListComplaintSuccess: ${getListComplaintSuccess.toString()},listComplaint: ${listComplaint.toString()},errorAuth: ${errorAuth.toString()},errorMsg: ${errorMsg.toString()}';
    return '{$string}';
  }
}
