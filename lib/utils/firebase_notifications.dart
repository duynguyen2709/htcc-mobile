import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hethongchamcong_mobile/data/local/receive_push_model.dart';

class FireBaseNotifications {
  static FireBaseNotifications instance;

  static FireBaseNotifications getInstance() {
    if (instance == null) {
      instance = new FireBaseNotifications();
    }
    return instance;
  }

  FireBaseNotifications() {
    _fireBaseMessaging = FirebaseMessaging();
  }

  FirebaseMessaging _fireBaseMessaging;

  FirebaseMessaging get fireBaseMessaging => _fireBaseMessaging;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool isDuplicate = true;

  BuildContext context;

  void setUpFirebase() async {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');

    var iOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      onDidReceiveLocalNotification: ((i, s1, s2, s3) {}),
    );

    var initSetttings = new InitializationSettings(android, iOS);

    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onSelectNotification);

    if (Platform.isIOS) iosPermission();

//    var tokenPush = await _fireBaseMessaging.getToken();
//
//    log("Token push: " + tokenPush);
  }

  void firebaseCloudMessagingListeners(BuildContext context) {
    this.context = context;
    _fireBaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        log("onMessageeeeeeeeeeeeeeee");
//        isDuplicate = false;
        pushNoti(message, flutterLocalNotificationsPlugin);
      },
      onResume: (Map<String, dynamic> message) async {
        log("onResumseeeeeeeeeeeeeee");
//      var prefs = await SharedPreferences.getInstance();
//      String shared = prefs.getString(SHARED_TOKEN);
//      if (shared != null && shared.isNotEmpty) {
//        IntroduceShare.navigate(this.context);
//      }
      },
      onLaunch: (Map<String, dynamic> message) async {
        log("onLaunchhhhhhhhhhhhhhhh");
//      var prefs = await SharedPreferences.getInstance();
//      String shared = prefs.getString(SHARED_TOKEN);
//      if (shared != null && shared.isNotEmpty) {
//        IntroduceShare.navigate(this.context);
//      }
      },
    );
  }

  void iosPermission() {
    _fireBaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _fireBaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  pushNoti(Map<String, dynamic> message, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    String title = "";
    String content = "";
    String json2 = "";
    if (Platform.isAndroid) {
      PushAndroidResponse pushResponse = PushAndroidResponse();
      json2 = json.encode(message);
      pushResponse = PushAndroidResponse.fromRawJson(json2);
      title = pushResponse.notification.title ?? "";
      content = pushResponse.notification.body ?? "";
    } else {
      PushIosResponse pushResponse = PushIosResponse();
      json2 = json.encode(message);
      pushResponse = PushIosResponse.fromRawJson(json2);
      title = pushResponse.aps.alert.title ?? "";
      content = pushResponse.aps.alert.body ?? "";
    }

    log("title: $title \n" + "content: $content");
    log("${json2}");

    var android = new AndroidNotificationDetails('CHANEL_ID_PUSH_POSAPP', 'PosApp Report', 'PosApp Report Push',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails(presentAlert: true, presentSound: true, presentBadge: true);
    var platform = new NotificationDetails(android, iOS);

    await flutterLocalNotificationsPlugin.show(0, title, content, platform);
    popupMessage(title, content);
  }

  Future<void> onSelectNotification(String payload) {}

  Future popupMessage(String title, String content) {}
}
