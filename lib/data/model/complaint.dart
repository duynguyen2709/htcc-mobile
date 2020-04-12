import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';

Complaint userDataFromJson(String str) => Complaint.fromJson(json.decode(str));

String userDataToJson(Complaint data) => json.encode(data.toJson());

class Complaint extends BaseModel {
  String complaintId;
  String date;
  String time;
  int receiverType;
  int isAnonymous;
  String sender;
  String category;
  List<String> content;
  List<String> images;
  int status;
  List<String> response;
  String contentPost;

  Complaint({
    this.complaintId,
    this.date,
    this.time,
    this.receiverType,
    this.isAnonymous,
    this.sender,
    this.category,
    this.content,
    this.images,
    this.status,
    this.response,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        complaintId: json["complaintId"],
        date: json["date"],
        time: json["time"],
        receiverType: json["receiverType"],
        isAnonymous: json["isAnonymous"],
        sender: json["sender"],
        category: json["category"],
        content: List<String>.from(json["content"].map((x) => x)),
        images: List<String>.from(json["images"].map((x) => x)),
        status: json["status"],
        response: List<String>.from(json["response"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "complaintId": complaintId,
        "date": date,
        "time": time,
        "receiverType": receiverType,
        "isAnonymous": isAnonymous,
        "sender": sender,
        "category": category,
        "content": List<String>.from(content.map((x) => x)),
        "images": List<String>.from(images.map((x) => x)),
        "status": status,
        "response": List<String>.from(response.map((x) => x)),
      };
}

class CreateComplaintParam {
  String username;
  String companyId;
  int clientTime;
  Complaint complaint;
  List<MultipartFile> images;

  CreateComplaintParam({this.username, this.companyId, this.clientTime, this.complaint, this.images});

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

class RePostComplaintParam {
  String complaintId;
  String content;
  String date;

  RePostComplaintParam({this.complaintId, this.content, this.date});
}
