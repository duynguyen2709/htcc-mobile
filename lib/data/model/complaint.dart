import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';

String listComplaintToJson(List<Complaint> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Complaint extends BaseModel {
  String category;
  String complaintId;
  String content;
  String date;
  List<String> images;
  int isAnonymous;
  int receiverType;
  String response;
  int status;
  String time;

  Complaint(
      {this.category,
        this.complaintId,
        this.content,
        this.date,
        this.images,
        this.isAnonymous,
        this.receiverType,
        this.response,
        this.status,
        this.time});

  Complaint.fromJson(Map<String, dynamic> json)  : super.fromJson(json){
    category = json['category'];
    complaintId = json['complaintId'];
    content = json['content'];
    date = json['date'];
    images = json['images'].cast<String>();
    isAnonymous = json['isAnonymous'];
    receiverType = json['receiverType'];
    response = json['response'];
    status = json['status'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['complaintId'] = this.complaintId;
    data['content'] = this.content;
    data['date'] = this.date;
    data['images'] = this.images;
    data['isAnonymous'] = this.isAnonymous;
    data['receiverType'] = this.receiverType;
    data['response'] = this.response;
    data['status'] = this.status;
    data['time'] = this.time;
    return data;
  }
}

class CreateComplaintParam{
  String username;
  String companyId;
  int clientTime;
  Complaint complaint;
  List<MultipartFile> images;
  CreateComplaintParam({this.username, this.companyId,this.clientTime, this.complaint, this.images});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['clientTime'] = this.clientTime;
    data['category'] = this.complaint.category;
    data['companyId'] = this.companyId;
    data['content'] = this.complaint.content;
    data['images'] = this.images;
    data['receiverType'] = this.complaint.receiverType;
    return data;
  }
}