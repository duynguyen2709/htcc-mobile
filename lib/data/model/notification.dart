import 'package:hethongchamcong_mobile/data/base/base_model.dart';

class ItemNotification extends BaseModel {
  String title;
  String content;
  String date;
  String img;

  ItemNotification({this.title, this.content, this.date, this.img});

  @override
  ItemNotification.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    title = json['title'];
    content = json['content'];
    date = json['date'];
    img = json['img'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    data['img'] = this.img;
    return data;
  }
}
