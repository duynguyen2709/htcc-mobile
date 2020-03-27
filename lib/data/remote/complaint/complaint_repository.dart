import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/base_repository.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/complaint.dart';
import 'package:hethongchamcong_mobile/data/model/empty.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/utils/handle_respone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dio.dart';

class ComplaintRepository extends BaseRepository {
  ComplaintRepository() : super();

  Future<Result> postComplaint(CreateComplaintParam param) async {
    var data = FormData.fromMap({
      "images": param.images,
      "username": param.username,
      "companyId": param.companyId,
      "clientTime": param.clientTime,
      "isAnonymous": param.complaint.isAnonymous,
      "receiverType ": param.complaint.receiverType,
      "content": param.complaint.content,
      "category": param.complaint.category
    });
    try {
      RequestOptions options = RequestOptions();
      var sharedPreference = await SharedPreferences.getInstance();
      var token = sharedPreference.getString(Constants.TOKEN);
      options.headers.addAll({
        "authorization": "Bearer $token",
        "Content-Type": "multipart/form-data"
      });
      var response = await dio.post(DioManager.PATH_COMPLAINT,
          data: data, options: options);
      var result =
          handleResponse<Empty>(response, (json) => Empty.fromJson(json));
      return result;
    } catch (error) {
      return handleError(error);
    }
  }

  Future<Result> getListComplaint(String time) async {

    try {
      var pref  = await SharedPreferences.getInstance();
      String jsonUser = pref.getString(Constants.USER);
      if (jsonUser != null && jsonUser.isNotEmpty){
        User user = User.fromJson(json.decode(jsonUser));
        String realPath = DioManager.PATH_COMPLAINT + "/${user.companyId}/${user.username}/$time";
        var response = await dio.get(realPath);
        var result =
        handleListResponse<Complaint>(response, (json) => Complaint.fromJson(json));
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
