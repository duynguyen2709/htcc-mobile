import 'dart:convert';

import 'package:hethongchamcong_mobile/utils/convert.dart';

FormLeaving userDataFromJson(String str) => FormLeaving.fromJson(json.decode(str));

String userDataToJson(FormLeaving data) => json.encode(data.toJson());

class FormLeaving {
  String category;
  int clientTime;
  String companyId;
  List<DetailSubmitLeaving> detail;
  String reason;
  String username;

  FormLeaving({
    this.category,
    this.clientTime,
    this.companyId,
    this.detail,
    this.reason,
    this.username,
  });

  factory FormLeaving.fromJson(Map<String, dynamic> json) => FormLeaving(
        category: json["category"],
        clientTime: json["clientTime"],
        companyId: json["companyId"],
        detail: List<DetailSubmitLeaving>.from(json["detail"].map((x) => DetailSubmitLeaving.fromJson(x))),
        reason: json["reason"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "clientTime": clientTime,
        "companyId": companyId,
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
        "reason": reason,
        "username": username,
      };
}

class DetailSubmitLeaving {
  int dateInt;
  DateTime date;
  int session;
  bool isCheck = true;
  DetailSubmitLeaving({this.dateInt,this.date,this.session});

  DetailSubmitLeaving.int({
    this.dateInt,
    this.session,
  }) {
    this.date = Convert.convertIntToDate(this.dateInt);
  }

  DetailSubmitLeaving.dateTime({
    this.date,
    this.session,
  }) {
    this.dateInt = Convert.convertDateToInt(this.date);
  }

  factory DetailSubmitLeaving.fromJson(Map<String, dynamic> json) => DetailSubmitLeaving.int(
        dateInt: json["date"],
        session: json["session"],
      );

  Map<String, dynamic> toJson() => {
        "date": Convert.convertDateToInt(date),
        "session": session,
      };
}
