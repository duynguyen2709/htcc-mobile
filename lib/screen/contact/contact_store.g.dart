// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactStore on _ContactStore, Store {
  final _$isLoadingAtom = Atom(name: '_ContactStore.isLoading');

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

  final _$getListContactSuccessAtom =
      Atom(name: '_ContactStore.getListContactSuccess');

  @override
  bool get getListContactSuccess {
    _$getListContactSuccessAtom.context
        .enforceReadPolicy(_$getListContactSuccessAtom);
    _$getListContactSuccessAtom.reportObserved();
    return super.getListContactSuccess;
  }

  @override
  set getListContactSuccess(bool value) {
    _$getListContactSuccessAtom.context.conditionallyRunInAction(() {
      super.getListContactSuccess = value;
      _$getListContactSuccessAtom.reportChanged();
    }, _$getListContactSuccessAtom,
        name: '${_$getListContactSuccessAtom.name}_set');
  }

  final _$getListFilterSuccessAtom =
      Atom(name: '_ContactStore.getListFilterSuccess');

  @override
  bool get getListFilterSuccess {
    _$getListFilterSuccessAtom.context
        .enforceReadPolicy(_$getListFilterSuccessAtom);
    _$getListFilterSuccessAtom.reportObserved();
    return super.getListFilterSuccess;
  }

  @override
  set getListFilterSuccess(bool value) {
    _$getListFilterSuccessAtom.context.conditionallyRunInAction(() {
      super.getListFilterSuccess = value;
      _$getListFilterSuccessAtom.reportChanged();
    }, _$getListFilterSuccessAtom,
        name: '${_$getListFilterSuccessAtom.name}_set');
  }

  final _$getMoreSuccessAtom = Atom(name: '_ContactStore.getMoreSuccess');

  @override
  bool get getMoreSuccess {
    _$getMoreSuccessAtom.context.enforceReadPolicy(_$getMoreSuccessAtom);
    _$getMoreSuccessAtom.reportObserved();
    return super.getMoreSuccess;
  }

  @override
  set getMoreSuccess(bool value) {
    _$getMoreSuccessAtom.context.conditionallyRunInAction(() {
      super.getMoreSuccess = value;
      _$getMoreSuccessAtom.reportChanged();
    }, _$getMoreSuccessAtom, name: '${_$getMoreSuccessAtom.name}_set');
  }

  final _$listContactAtom = Atom(name: '_ContactStore.listContact');

  @override
  List<Contact> get listContact {
    _$listContactAtom.context.enforceReadPolicy(_$listContactAtom);
    _$listContactAtom.reportObserved();
    return super.listContact;
  }

  @override
  set listContact(List<Contact> value) {
    _$listContactAtom.context.conditionallyRunInAction(() {
      super.listContact = value;
      _$listContactAtom.reportChanged();
    }, _$listContactAtom, name: '${_$listContactAtom.name}_set');
  }

  final _$listFilterAtom = Atom(name: '_ContactStore.listFilter');

  @override
  FilterList get listFilter {
    _$listFilterAtom.context.enforceReadPolicy(_$listFilterAtom);
    _$listFilterAtom.reportObserved();
    return super.listFilter;
  }

  @override
  set listFilter(FilterList value) {
    _$listFilterAtom.context.conditionallyRunInAction(() {
      super.listFilter = value;
      _$listFilterAtom.reportChanged();
    }, _$listFilterAtom, name: '${_$listFilterAtom.name}_set');
  }

  final _$errorAuthAtom = Atom(name: '_ContactStore.errorAuth');

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

  final _$errorMsgAtom = Atom(name: '_ContactStore.errorMsg');

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

  final _$perPageAtom = Atom(name: '_ContactStore.perPage');

  @override
  int get perPage {
    _$perPageAtom.context.enforceReadPolicy(_$perPageAtom);
    _$perPageAtom.reportObserved();
    return super.perPage;
  }

  @override
  set perPage(int value) {
    _$perPageAtom.context.conditionallyRunInAction(() {
      super.perPage = value;
      _$perPageAtom.reportChanged();
    }, _$perPageAtom, name: '${_$perPageAtom.name}_set');
  }

  final _$canLoadMoreAtom = Atom(name: '_ContactStore.canLoadMore');

  @override
  bool get canLoadMore {
    _$canLoadMoreAtom.context.enforceReadPolicy(_$canLoadMoreAtom);
    _$canLoadMoreAtom.reportObserved();
    return super.canLoadMore;
  }

  @override
  set canLoadMore(bool value) {
    _$canLoadMoreAtom.context.conditionallyRunInAction(() {
      super.canLoadMore = value;
      _$canLoadMoreAtom.reportChanged();
    }, _$canLoadMoreAtom, name: '${_$canLoadMoreAtom.name}_set');
  }

  final _$getFilterListAsyncAction = AsyncAction('getFilterList');

  @override
  Future getFilterList() {
    return _$getFilterListAsyncAction.run(() => super.getFilterList());
  }

  final _$getContactAsyncAction = AsyncAction('getContact');

  @override
  Future getContact(
      {@required String departmentId,
      @required String officeId,
      @required int page,
      int perPage}) {
    return _$getContactAsyncAction.run(() => super.getContact(
        departmentId: departmentId,
        officeId: officeId,
        page: page,
        perPage: perPage));
  }

  final _$searchContactAsyncAction = AsyncAction('searchContact');

  @override
  Future searchContact({String keyword, @required int page, int perPage}) {
    return _$searchContactAsyncAction.run(() =>
        super.searchContact(keyword: keyword, page: page, perPage: perPage));
  }

  final _$getMoreContactAsyncAction = AsyncAction('getMoreContact');

  @override
  Future getMoreContact(
      {String departmentId,
      String officeId,
      String keyword,
      int page,
      int perPage}) {
    return _$getMoreContactAsyncAction.run(() => super.getMoreContact(
        departmentId: departmentId,
        officeId: officeId,
        keyword: keyword,
        page: page,
        perPage: perPage));
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},getListContactSuccess: ${getListContactSuccess.toString()},getListFilterSuccess: ${getListFilterSuccess.toString()},getMoreSuccess: ${getMoreSuccess.toString()},listContact: ${listContact.toString()},listFilter: ${listFilter.toString()},errorAuth: ${errorAuth.toString()},errorMsg: ${errorMsg.toString()},perPage: ${perPage.toString()},canLoadMore: ${canLoadMore.toString()}';
    return '{$string}';
  }
}
