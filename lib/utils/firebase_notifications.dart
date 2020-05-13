import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/local/receive_push_model.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseNotifications {
  static FireBaseNotifications instance;

  static FireBaseNotifications getInstance() {
    if (instance == null) {
      instance = new FireBaseNotifications();
    }
    return instance;
  }

  PublishSubject<int> notifyStream = PublishSubject();

  static void dispose() {
    getInstance()._fireBaseMessaging = null;
    getInstance().notifyStream.close();
  }

  FireBaseNotifications() {
    _fireBaseMessaging = FirebaseMessaging();
  }

  FirebaseMessaging _fireBaseMessaging;

  FirebaseMessaging get fireBaseMessaging => _fireBaseMessaging;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool isConfigured = false;

  bool shouldHandle = false;

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
    );

    if (Platform.isIOS) {
      await iosPermission();
    }

    var initSettings = new InitializationSettings(android, iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: onSelectNotification);

    var tokenPush = await _fireBaseMessaging.getToken();

    log("Token push: " + tokenPush);
  }

  void firebaseCloudMessagingListeners(BuildContext context) {
    this.context = context;
    if (isConfigured == false) {
      _fireBaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          if (shouldHandle) {
            notifyStream.add(1);
            log("onMessageeeeeeeeeeeeeeee");
            pushNotification(message, flutterLocalNotificationsPlugin);
          }
        },
        onResume: (Map<String, dynamic> message) async {
          if (shouldHandle) {
            log("onResumseeeeeeeeeeeeeee");
            handleReceivePush(message);
          }
        },
        onLaunch: (Map<String, dynamic> message) async {
          if (shouldHandle) {
            log("onLaunchhhhhhhhhhhhhhhh");
            handleReceivePush(message);
          }
        },
      );
      isConfigured = true;
    }
  }

  Future<bool> iosPermission() async {
    _fireBaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    return _fireBaseMessaging
        .requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  pushNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    String title = '';
    String content = '';
    if (Platform.isIOS) {
      title = message['title'];
      content = message['content'];
    } else {
      title = message['data']['title'];
      content = message['data']['content'];
    }

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
    log("Test fcm push");
    notifyStream.add(1);
    RouteModel msg = convertMessage(message);
    routeHandle(int.parse(msg.screenId));
    await Injector.notificationRepository.updateStatusNotification(msg.notiId, 1);
    notifyStream.add(1);
  }

  routeHandle(int screenId) async {
    if (await checkAuth()) {
      switch (screenId) {
        case Constants.defaultScreen:
          {
            Navigator.pushNamedAndRemoveUntil(context, Constants.home_screen, (Route<dynamic> route) => false,
                arguments: 1);

            break;
          }
        case Constants.checkInScreen:
          {
            Navigator.pushNamedAndRemoveUntil(context, Constants.home_screen, (Route<dynamic> route) => false,
                arguments: 1);

            break;
          }
        case Constants.leavingScreen:
          {
            Navigator.pushNamedAndRemoveUntil(context, Constants.home_screen, (Route<dynamic> route) => false,
                arguments: 1);

            break;
          }
        case Constants.statisticScreen:
          {
            Navigator.pushNamedAndRemoveUntil(context, Constants.home_screen, (Route<dynamic> route) => false,
                arguments: 2);
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
    } else {
      Navigator.pushNamed(context, Constants.login_screen);
    }
  }

  Future<bool> checkAuth() async {
    SharedPreferences pref = await Pref.getInstance();
    return (pref.getString(Constants.TOKEN) != null && pref.getString(Constants.TOKEN).isNotEmpty);
  }

  RouteModel convertMessage(Map<String, dynamic> message) {
    String json2 = "";
    if (Platform.isAndroid) {
      return RouteModel(
        notiId: message['data']['notiId'],
        title: message['data']['title'],
        content: message['data']['content'],
        screenId: message['data']['screenId'],
      );
    } else {
      return RouteModel(
        notiId: message['notiId'],
        title: message['title'],
        content: message['content'],
        screenId: message['screenId'],
      );
    }
  }
}
