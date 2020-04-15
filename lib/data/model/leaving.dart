// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

import 'package:hethongchamcong_mobile/data/base/base_model.dart';

LeavingData userDataFromJson(String str) => LeavingData.fromJson(json.decode(str));

String userDataToJson(LeavingData data) => json.encode(data.toJson());

class LeavingData extends BaseModel {
  List<String> categories;
  double leftDays =0;
  List<ListRequest> listRequest;
  double totalDays =0;
  double usedDays= 0;
  double externalDaysOff = 0;

  LeavingData({
    this.categories,
    this.leftDays,
    this.listRequest,
    this.totalDays,
    this.usedDays,
    this.externalDaysOff,
  });

  factory LeavingData.fromJson(Map<String, dynamic> json) => LeavingData(
        categories: List<String>.from(json["categories"].map((x) => x)),
        leftDays: json["leftDays"].toDouble(),
        listRequest: List<ListRequest>.from(json["listRequest"].map((x) => ListRequest.fromJson(x))),
        totalDays: json["totalDays"].toDouble(),
        usedDays: json["usedDays"].toDouble(),
        externalDaysOff: json["externalDaysOff"].toDouble()
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "leftDays": leftDays,
        "listRequest": List<dynamic>.from(listRequest.map((x) => x.toJson())),
        "totalDays": totalDays,
        "usedDays": usedDays,
    "externalDaysOff" : externalDaysOff,
      };
}

class ListRequest {
  String approver;
  String category;
  DateTime dateFrom;
  DateTime dateTo;
  List<Detail> detail;
  String leavingRequestId;
  DateTime submitDate;
  String reason;
  String response;
  int status;

  ListRequest({
    this.approver,
    this.category,
    this.dateFrom,
    this.dateTo,
    this.detail,
    this.leavingRequestId,
    this.reason,
    this.response,
    this.status,
    this.submitDate
  });

  factory ListRequest.fromJson(Map<String, dynamic> json) => ListRequest(
        approver: json["approver"],
        category: json["category"],
        dateFrom: DateTime.parse(json["dateFrom"]),
        dateTo: DateTime.parse(json["dateTo"]),
        detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
        leavingRequestId: json["leavingRequestId"],
        reason: json["reason"],
        response: json["response"],
        status: json["status"],
        submitDate: DateTime.parse(json["dateSubmit"])
      );

  Map<String, dynamic> toJson() => {
        "approver": approver,
        "category": category,
        "dateFrom":
            "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
        "dateTo":
            "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
        "leavingRequestId": leavingRequestId,
        "reason": reason,
        "response": response,
        "status": status,
        "submitDate":  "${submitDate.year.toString().padLeft(4, '0')}-${submitDate.month.toString().padLeft(2, '0')}-${submitDate.day.toString().padLeft(2, '0')}",
      };
}

class Detail {
  String date;
  int session;

  Detail({
    this.date,
    this.session,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        date: json["date"],
        session: json["session"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "session": session,
      };
}
