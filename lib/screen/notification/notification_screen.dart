import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/notification.dart';
import 'package:hethongchamcong_mobile/screen/dialog/app_dialog.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/custom_app_bar.dart';
import 'package:hethongchamcong_mobile/screen/widget/empty_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/paged_list_view.dart';
import 'package:hethongchamcong_mobile/screen/widget/retry_screen.dart';
import 'package:hethongchamcong_mobile/utils/convert.dart';
import 'package:hethongchamcong_mobile/utils/firebase_notifications.dart';
import 'package:mobx/mobx.dart';

import 'notification_screen_store.dart';

class NotificationScreen extends StatefulWidget {
  final MainScreenState mainScreenState;

  NotificationScreen({this.mainScreenState});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with WidgetsBindingObserver {
  NotificationScreenStore notificationScreenStore;

  GlobalKey<PagedListViewState> globalKey = GlobalKey();

  ScrollController controller;

  DateTime dateTimeNow;

  @override
  void initState() {
    super.initState();
    controller = new ScrollController();

    controller.addListener(_scrollListener);

    notificationScreenStore = NotificationScreenStore();

    notificationScreenStore.init();

    widget.mainScreenState.mainScreenStore.getCountNotification();

    FireBaseNotifications.getInstance().notifyStream.listen((int event) {
      notificationScreenStore.init();
      widget.mainScreenState.mainScreenStore.getCountNotification();
    });

    reaction((_) => notificationScreenStore.msgLoadMore, (String msg) {
      if (msg != null && msg.isNotEmpty) {
        _showErrorDialog(msg);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      notificationScreenStore.init();
      widget.mainScreenState.mainScreenStore.getCountNotification();
    }
  }

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange) {
      loadMore();
    }
  }

  routeHandling(int flagScreen) {
    switch (flagScreen) {
      case Constants.defaultScreen:
        {
          break;
        }
      case Constants.checkInScreen:
        {
          widget.mainScreenState.setSelectedPage(0);
          break;
        }
      case Constants.leavingScreen:
        {
          widget.mainScreenState.setSelectedPage(1);
          break;
        }
      case Constants.statisticScreen:
        {
          widget.mainScreenState.setSelectedPage(2);
          break;
        }
      case Constants.accountScreen:
        {
          Navigator.pushNamed(context, Constants.account_screen);
          break;
        }
      case Constants.contactScreen:
        {
          Navigator.pushNamed(context, Constants.contacts_screen);
          break;
        }
      case Constants.salaryScreen:
        {
          break;
        }
      case Constants.complaintScreen:
        {
          Navigator.pushNamed(context, Constants.complaint_screen);
          break;
        }
      default:
        {}
    }
  }

  Widget buildNotificationItem(NotificationPush model) {
    return (model.hasRead)
        ? Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(8, 2, 8, 4),
            child: Card(
              child: InkWell(
                onTap: () {
                  log(model.screenId.toString());
                  routeHandling(model.screenId);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 35,
                        height: 35,
                        margin: EdgeInsets.all(8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/gif/loading.gif',
                              image: model.iconUrl,
                              fit: BoxFit.cover,
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 15),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2.0),
                                  child: Text(
                                    model.title,
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    model.content,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2.0),
                                  child: Text(
                                    model.date,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(8, 2, 8, 4),
            child: ClipRect(
              child: Banner(
                child: Card(
                  child: InkWell(
                    onTap: () {
                      notificationScreenStore.updateStatusNotification(model.notiId, 1);
                      widget.mainScreenState.mainScreenStore.setNumber(1);
                      log(model.screenId.toString());
                      routeHandling(model.screenId);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 35,
                            height: 35,
                            margin: EdgeInsets.all(8),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/gif/loading.gif',
                                  image: model.iconUrl,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 15),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 2.0),
                                      child: Text(
                                        model.title,
                                        maxLines: 1,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4.0),
                                      child: Text(
                                        model.content,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 2.0),
                                      child: Text(
                                        model.date,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                message: 'NEW',
                color: Colors.red,
                location: BannerLocation.topEnd,
              ),
            ),
          );
  }

  Widget buildHeaderItem(DateTime datetime, int position) {
    DateTime tmpDateBefore;
    if (position - 1 >= 0 && notificationScreenStore.list[position - 1] != null) {
      tmpDateBefore = Convert.convertStringToDate(notificationScreenStore.list[position - 1].date);
    }
    if (tmpDateBefore == null) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
          child: Text("Tháng ${datetime.month} Năm ${datetime.year}", style: TextStyle(fontWeight: FontWeight.w500)),
        ),
      );
    } else {
      if (tmpDateBefore.month == datetime.month && tmpDateBefore.year == datetime.year) {
        return SizedBox();
      } else {
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
            child: Text("Tháng ${datetime.month} Năm ${datetime.year}", style: TextStyle(fontWeight: FontWeight.w500)),
          ),
        );
      }
    }
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
          onPressed: () {
            AppDialog.showDialogYN(context, "Bạn có muốn đánh dấu đã đọc tất cả thông tin ?", () {
              notificationScreenStore.updateStatusNotification("", 0);
              widget.mainScreenState.mainScreenStore.setNumber(0);
            }, () {});
          },
          onTitleTapped: () {}),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (BuildContext context) {
              if (notificationScreenStore.msg.isNotEmpty)
                return RetryScreen(
                  refresh: refresh,
                  msg: notificationScreenStore.msg,
                );
              else {
                if (notificationScreenStore.list == null || notificationScreenStore.list.isEmpty) {
                  return EmptyScreen(
                    refresh: refresh,
                  );
                } else
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: refresh,
                          child: new ListView.builder(
                            controller: controller,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, position) {
                              return Column(
                                children: <Widget>[
                                  buildHeaderItem(Convert.convertStringToDate(notificationScreenStore.list[position].date), position),
                                  buildNotificationItem(notificationScreenStore.list[position]),
                                ],
                              );
                            },
                            itemCount: notificationScreenStore.list.length,
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                      )
                    ],
                  );
              }
            },
          ),
          Observer(
            builder: (BuildContext context) {
              if (notificationScreenStore.isLoading == true) {
                return LoadingScreen();
              }
              return SizedBox();
            },
          )
        ],
      ),
    );
  }

  void loadMore() async {
    log("Load More");
    await notificationScreenStore.loadNextPage();
  }

  Future<void> refresh() async {
    notificationScreenStore.init();
    widget.mainScreenState.mainScreenStore.getCountNotification();
  }
}
