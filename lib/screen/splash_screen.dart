import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/presenter/splash_screen_presenter.dart';

import '../constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> implements SplashContract {
  SplashPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = SplashPresenter(this);

    _presenter.authenticate();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.9],
          colors: [
            Color(0xFFFC5C7D),
            Color(0xFF6A82FB),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 90.0),
      child: Image.asset(
        Constants.ic_logo,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  @override
  void onHideLoading() {
    // TODO: implement onHideLoading
  }

  @override
  void onShowLoading() {
    // TODO: implement onShowLoading
  }

  @override
  void goToNextScreen(String status, HashMap<String, Object> hashMap) {
    switch (status) {
      case Constants.isLogin:
        {
          Navigator.pushReplacementNamed(context, Constants.login_screen);
          break;
        }
      default:
        {
          Navigator.pushReplacementNamed(context, Constants.main_screen);
        }
        break;
    }
  }
}
