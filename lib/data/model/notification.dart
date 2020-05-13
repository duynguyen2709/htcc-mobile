import 'package:hethongchamcong_mobile/data/base/base_model.dart';

class NotificationPush extends BaseModel {
  String notiId;
  int screenId;
  String title;
  String content;
  String date;
  String time;
  String iconId;
  String iconUrl;
  bool hasRead;

  NotificationPush({
    this.notiId,
    this.screenId,
    this.title,
    this.content,
    this.date,
    this.time,
    this.iconId,
    this.iconUrl,
    this.hasRead,
  });

  factory NotificationPush.fromJson(Map<String, dynamic> json) => NotificationPush(
        notiId: json["notiId"],
        screenId: json["screenId"],
        title: json["title"],
        content: json["content"],
        date: json["date"],
        time: json["time"],
        iconId: json["iconId"],
        iconUrl: json["iconUrl"],
        hasRead: json["hasRead"],
      );

  Map<String, dynamic> toJson() => {
        "notiId": notiId,
        "screenId": screenId,
        "title": title,
        "content": content,
        "date": date,
        "time": time,
        "iconId": iconId,
        "iconUrl": iconUrl,
        "hasRead": hasRead,
      };
}
