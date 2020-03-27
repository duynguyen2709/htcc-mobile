import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/notification.dart';
import 'package:hethongchamcong_mobile/screen/widget/custom_app_bar.dart';
import 'package:hethongchamcong_mobile/screen/widget/paged_list_view.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<ItemNotification> list = new List();
  int page = 0;
  GlobalKey<PagedListViewState> globalKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    list.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
  }

  void getMoreData(int perPage, int page) {
    this.page= page;
    List<ItemNotification> newList = new List();
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    newList.add(ItemNotification(
        title: "Title",
        content: "Content",
        date: "23/03/2020",
        img: "https://via.placeholder.com/150"));
    Future.delayed(const Duration(milliseconds: 1000), () {
      globalKey.currentState.addList(newList);
    });

  }

  Widget buildNotificationItem(ItemNotification model) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(8, 2, 8, 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                margin: EdgeInsets.all(8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/login_header.png',
                      image: model.img,
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      model.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(model.content),
                    Text(
                      model.date,
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(Constants.titleErrorDialog),
          content: Text(errorMessage),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(Constants.buttonErrorDialog),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: "Thông báo",
            child: Container(),
            onPressed: () {},
            onTitleTapped: () {}),
        body: Column(
          children: <Widget>[
            Expanded(
              child: PagedListView(
                key: globalKey,
                list: list,
                loadMoreDataFunc: (perPage,page) => getMoreData(perPage,page),
                buildItemViewFunc: (model)=> buildNotificationItem(model),
                page: this.page,
                perPage: 10,
              ),
            ),
            Container(
              height: 60,
            )
          ],
        ));
  }
}
//class ItemNotification extends StatefulWidget {
//  @override
//  _ItemNotificationState createState() => _ItemNotificationState();
//}
//
//class _ItemNotificationState extends State<ItemNotification> with SingleTickerProviderStateMixin {
//  AnimationController _controller;
//
//  @override
//  void initState() {
//    _controller = AnimationController(vsync: this);
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//    width: MediaQuery.of(context).size.width,
//    padding: EdgeInsets.fromLTRB(8, 2, 8, 4),
//    child: Card(
//      child: Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Container(
//              width: 32,
//              height: 32,
//              margin: EdgeInsets.all(8),
//              child: ClipRRect(
//                  borderRadius: BorderRadius.circular(100.0),
//                  child: FadeInImage.assetNetwork(
//                    placeholder: 'assets/login_header.png',
//                    image: 'https://via.placeholder.com/150',
//                    fit: BoxFit.cover,
//                  )) ,),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text("Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
//                  Text("Content"),
//                  Text("22/03/2020", style: TextStyle(color: Colors.grey),)
//                ],
//              ),
//            )
//          ],
//        ),
//      ),
//    ),
//    );
//  }
//}
//
