import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hethongchamcong_mobile/data/local/receive_push_model.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';

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
      defaultPresentAlert: false,
      defaultPresentBadge: false,
      defaultPresentSound: false,
      onDidReceiveLocalNotification: ((i, s1, s2, s3) {}),
    );

    if (Platform.isIOS) await iosPermission();

    var initSetttings = new InitializationSettings(android, iOS);

    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onSelectNotification);

    var tokenPush = await _fireBaseMessaging.getToken();

    log("Token push: " + tokenPush);
  }

  void firebaseCloudMessagingListeners(BuildContext context) {
    this.context = context;
    _fireBaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        log("onMessageeeeeeeeeeeeeeee");
        pushNoti(message, flutterLocalNotificationsPlugin);
      },
      onResume: (Map<String, dynamic> message) async {
        log("onResumseeeeeeeeeeeeeee");
        handleReceivePush(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        log("onLaunchhhhhhhhhhhhhhhh");
        handleReceivePush(message);
      },
    );
  }

  Future<bool> iosPermission() async {
    _fireBaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    return _fireBaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  pushNoti(Map<String, dynamic> message, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    String title = "";
    String content = "";
    String json2 = "";

    log("title: $title \n" + "content: $content");
    log("${json2}");

    var android = new AndroidNotificationDetails('CHANEL_ID_PUSH_POSAPP', 'PosApp Report', 'PosApp Report Push',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);
    var platform = new NotificationDetails(android, iOS);

    await flutterLocalNotificationsPlugin.show(1, title, content, platform, payload: json.encode(message));
  }

  Future<void> onSelectNotification(String payload) async {
    return await handleReceivePush(json.decode(payload));
  }

  handleReceivePush(Map<String, dynamic> message) async {
    var msg = convertMessage(message);
    var prefs = await Pref.getInstance();
    String token = prefs.getString(Constants.TOKEN);
    if (token != null && token.isNotEmpty) {
      routeHandle();
    }
  }

  routeHandle() {

  }

  convertMessage(Map<String, dynamic> message) {
    String json2 = "";
    if (Platform.isAndroid) {
      PushAndroidResponse pushResponse = PushAndroidResponse();
      json2 = json.encode(message);
      pushResponse = PushAndroidResponse.fromRawJson(json2);
    } else {
      PushIosResponse pushResponse = PushIosResponse();
      json2 = json.encode(message);
      pushResponse = PushIosResponse.fromRawJson(json2);
    }
  }
}
