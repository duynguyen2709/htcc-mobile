import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/login_response.dart';
import 'package:hethongchamcong_mobile/screen/login/login_screen.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:hethongchamcong_mobile/screen/password/password_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/quick_login/quick_login.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  final bool isLogin;
  final List<UserData> users;

  const SplashScreen({Key key, this.isLogin, this.users}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => widget.isLogin? MainScreen() : (widget.users!=null && widget.users.length>0) ? QuickLogin(users: widget.users,) : LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            child: Image.asset(
              "assets/splash_screen_bg.png",
            ),
            fit: BoxFit.cover,
          ),

        ],
      ),
    );
  }
}
