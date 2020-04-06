import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/complaint.dart';
import 'package:hethongchamcong_mobile/data/model/contact.dart';
import 'package:hethongchamcong_mobile/data/model/empty.dart';
import 'package:hethongchamcong_mobile/data/model/filter_list.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/utils/handle_respone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dio.dart';

class ContactRepository extends BaseRepository {
  ContactRepository() : super();

  Future<Result> getListContact(String departmentId,String officeId, String keyword,int page, int perPage) async {
    if(perPage==null) perPage=10;
    try {
      var pref  = await SharedPreferences.getInstance();
      String jsonUser = pref.getString(Constants.USER);
      if (jsonUser != null && jsonUser.isNotEmpty){
        User user = User.fromJson(json.decode(jsonUser));
        String realPath = DioManager.PATH_CONTACTS + "/${user.companyId}?${departmentId!=null ? 'department=$departmentId&' : ''}${officeId!=null ? 'officeId=$officeId&' : ''}${keyword!=null ? 'search=$keyword&' : ''}index=$page&size=$perPage";
        var response = await dio.get(realPath);
        var result =
        handleListResponse<Contact>(response, (json) => Contact.fromJson(json));
        return result;
      }
      else{
        return Error(status: Status.ERROR_AUTHENTICATE);
      }

    } catch (error) {
      return handleError(error);
    }
  }

  Future<Result> getListFilter() async {
    try {
      var pref  = await SharedPreferences.getInstance();
      String jsonUser = pref.getString(Constants.USER);
      if (jsonUser != null && jsonUser.isNotEmpty){
        User user = User.fromJson(json.decode(jsonUser));
        String realPath = DioManager.PATH_CONTACTS_FILTER + "/${user.companyId}";
        var response = await dio.get(realPath);
        var result = handleResponse<FilterList>(response, (json) => FilterList.fromJson(json));
        return result;
      }
      else{
        return Error(status: Status.ERROR_AUTHENTICATE);
      }

    } catch (error) {
      return handleError(error);
    }
  }
}
