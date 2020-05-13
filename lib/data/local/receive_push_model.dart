// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

PushAndroidResponse notificationResponseFromJson(String str) => PushAndroidResponse.fromJson(json.decode(str));

String notificationResponseToJson(PushAndroidResponse data) => json.encode(data.toJson());

class PushAndroidResponse {
  Notification notification;
  Data data;

  PushAndroidResponse({
    this.notification,
    this.data,
  });

  factory PushAndroidResponse.fromJson(Map<String, dynamic> json) => PushAndroidResponse(
        notification: Notification.fromJson(json["notification"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "notification": notification.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  String iconId;
  String notiId;
  String screenId;
  String date;
  String time;
  String title;
  String hasRead;
  String content;
  String iconUrl;

  Data({
    this.iconId,
    this.notiId,
    this.screenId,
    this.date,
    this.time,
    this.title,
    this.hasRead,
    this.content,
    this.iconUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        iconId: json["iconId"],
        notiId: json["notiId"],
        screenId: json["screenId"],
        date: json["date"],
        time: json["time"],
        title: json["title"],
        hasRead: json["hasRead"],
        content: json["content"],
        iconUrl: json["iconUrl"],
      );

  Map<String, dynamic> toJson() => {
        "iconId": iconId,
        "notiId": notiId,
        "screenId": screenId,
        "date": date,
        "time": time,
        "title": title,
        "hasRead": hasRead,
        "content": content,
        "iconUrl": iconUrl,
      };
}

class Notification {
  String title;
  String body;

  Notification({
    this.title,
    this.body,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
      };
}

class RouteModel {
  String notiId;
  String title;
  String content;
  String screenId;

  RouteModel({this.notiId, this.title, this.content, this.screenId});
}
