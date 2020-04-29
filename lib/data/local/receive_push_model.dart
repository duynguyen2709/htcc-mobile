// IOS
//    {
//      "gcm.n.e": "1",
//      "google.c.a.ts": "1577352372",
//      "data": "23423423",
//      "aps": {
//        "alert": {
//          "body": "hello textlskfklsfldsklfdskld\nhello",
//          "title": "Title"
//        },
//        "sound": "default",
//        "badge": 1
//      },
//      "google.c.a.c_id": "4320288604446115721",
//      "google.c.a.e": "1",
//      "gcm.notification.sound2": "default",
//      "gcm.message_id": "1577352372976653",
//      "google.c.a.udt": "0"
//    }
//
// Android
//    {
//      "notification": {
//        "body": "hello textlskfklsfldsklfdskld\nhello",
//        "title": "Title"
//      },
//      "data": {
//        "data": "23423423"
//      }
//    }

// To parse this JSON data, do
//
//     final pushResponse = pushResponseFromJson(jsonString);

import 'dart:convert';

class PushAndroidResponse {
  Notification notification;
  DataPush data;

  PushAndroidResponse({
    this.notification,
    this.data,
  });

  factory PushAndroidResponse.fromRawJson(String str) => PushAndroidResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PushAndroidResponse.fromJson(Map<String, dynamic> json) => new PushAndroidResponse(
    notification: json["notification"] == null ? null : Notification.fromJson(json["notification"]),
    data: json["data"] == null ? null : DataPush.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "notification": notification == null ? null : notification.toJson(),
    "data": data == null ? null : data.toJson(),
  };
}

class DataPush {
  dynamic isStartAutosync;
  dynamic pushType;
  dynamic urlUpdateApp;
  dynamic urlGuide;
  dynamic msg;
  dynamic isUpdateApp;

  DataPush({
    this.isStartAutosync,
    this.pushType,
    this.urlUpdateApp,
    this.urlGuide,
    this.msg,
    this.isUpdateApp,
  });

  factory DataPush.fromRawJson(String str) => DataPush.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataPush.fromJson(Map<String, dynamic> json) => new DataPush(
    isStartAutosync: json["is_start_autosync"],
    pushType: json["push_type"],
    urlUpdateApp: json["url_update_app"],
    urlGuide: json["url_guide"],
    msg: json["msg"],
    isUpdateApp: json["is_update_app"],
  );

  Map<String, dynamic> toJson() => {
    "is_start_autosync": isStartAutosync,
    "push_type": pushType,
    "url_update_app": urlUpdateApp,
    "url_guide": urlGuide,
    "msg": msg,
    "is_update_app": isUpdateApp,
  };
}

class Notification {
  dynamic title;
  dynamic body;

  Notification({
    this.title,
    this.body,
  });

  factory Notification.fromRawJson(String str) => Notification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notification.fromJson(Map<String, dynamic> json) => new Notification(
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
  };
}

// To parse this JSON data, do
//
//     final pushIosResponse = pushIosResponseFromJson(jsonString);
class PushIosResponse {
  String gcmNE;
  String googleCATs;
//  DataPush data;
  Aps aps;
  String googleCACId;
  String googleCAE;
  String gcmNotificationSound2;
  String gcmMessageId;
  String googleCAUdt;
  // Data push
  dynamic isStartAutosync;
  dynamic pushType;
  dynamic urlUpdateApp;
  dynamic urlGuide;
  dynamic msg;
  dynamic isUpdateApp;

  PushIosResponse({
    this.gcmNE,
    this.googleCATs,
//    this.data,
    this.aps,
    this.googleCACId,
    this.googleCAE,
    this.gcmNotificationSound2,
    this.gcmMessageId,
    this.googleCAUdt,
// data push
    this.isStartAutosync,
    this.pushType,
    this.urlUpdateApp,
    this.urlGuide,
    this.msg,
    this.isUpdateApp,
  });

  factory PushIosResponse.fromRawJson(String str) => PushIosResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PushIosResponse.fromJson(Map<String, dynamic> json) => PushIosResponse(
    gcmNE: json["gcm.n.e"] == null ? null : json["gcm.n.e"],
    googleCATs: json["google.c.a.ts"] == null ? null : json["google.c.a.ts"],
//    data: json["data"] == null ? null : DataPush.fromJson(json["data"]),
    aps: json["aps"] == null ? null : Aps.fromJson(json["aps"]),
    googleCACId: json["google.c.a.c_id"] == null ? null : json["google.c.a.c_id"],
    googleCAE: json["google.c.a.e"] == null ? null : json["google.c.a.e"],
    gcmNotificationSound2: json["gcm.notification.sound2"] == null ? null : json["gcm.notification.sound2"],
    gcmMessageId: json["gcm.message_id"] == null ? null : json["gcm.message_id"],
    googleCAUdt: json["google.c.a.udt"] == null ? null : json["google.c.a.udt"],
    // data push
    isStartAutosync: json["is_start_autosync"],
    pushType: json["push_type"],
    urlUpdateApp: json["url_update_app"],
    urlGuide: json["url_guide"],
    msg: json["msg"],
    isUpdateApp: json["is_update_app"],
  );

  Map<String, dynamic> toJson() => {
    "gcm.n.e": gcmNE == null ? null : gcmNE,
    "google.c.a.ts": googleCATs == null ? null : googleCATs,
//    "data": data == null ? null : data.toJson(),
    "aps": aps == null ? null : aps.toJson(),
    "google.c.a.c_id": googleCACId == null ? null : googleCACId,
    "google.c.a.e": googleCAE == null ? null : googleCAE,
    "gcm.notification.sound2": gcmNotificationSound2 == null ? null : gcmNotificationSound2,
    "gcm.message_id": gcmMessageId == null ? null : gcmMessageId,
    "google.c.a.udt": googleCAUdt == null ? null : googleCAUdt,
    // data push
    "is_start_autosync": isStartAutosync,
    "push_type": pushType,
    "url_update_app": urlUpdateApp,
    "url_guide": urlGuide,
    "msg": msg,
    "is_update_app": isUpdateApp,
  };
}

class Aps {
  Alert alert;
  String sound;
  int badge;

  Aps({
    this.alert,
    this.sound,
    this.badge,
  });

  factory Aps.fromRawJson(String str) => Aps.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Aps.fromJson(Map<String, dynamic> json) => Aps(
    alert: json["alert"] == null ? null : Alert.fromJson(json["alert"]),
    sound: json["sound"] == null ? null : json["sound"],
    badge: json["badge"] == null ? null : json["badge"],
  );

  Map<String, dynamic> toJson() => {
    "alert": alert == null ? null : alert.toJson(),
    "sound": sound == null ? null : sound,
    "badge": badge == null ? null : badge,
  };
}

class Alert {
  String body;
  String title;

  Alert({
    this.body,
    this.title,
  });

  factory Alert.fromRawJson(String str) => Alert.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    body: json["body"] == null ? null : json["body"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toJson() => {
    "body": body == null ? null : body,
    "title": title == null ? null : title,
  };
}

