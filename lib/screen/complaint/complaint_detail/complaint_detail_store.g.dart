// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ComplaintDetailStore on _ComplaintDetailStore, Store {
  final _$isLoadingAtom = Atom(name: '_ComplaintDetailStore.isLoading');

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

  final _$errorAuthAtom = Atom(name: '_ComplaintDetailStore.errorAuth');

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

  final _$errorMsgAtom = Atom(name: '_ComplaintDetailStore.errorMsg');

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

  final _$postComplaintSuccessAtom =
      Atom(name: '_ComplaintDetailStore.postComplaintSuccess');

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

  final _$rePostComplaintAsyncAction = AsyncAction('rePostComplaint');

  @override
  Future rePostComplaint(RePostComplaintParam rePostComplaintParam) {
    return _$rePostComplaintAsyncAction
        .run(() => super.rePostComplaint(rePostComplaintParam));
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},errorAuth: ${errorAuth.toString()},errorMsg: ${errorMsg.toString()},postComplaintSuccess: ${postComplaintSuccess.toString()}';
    return '{$string}';
  }
}
