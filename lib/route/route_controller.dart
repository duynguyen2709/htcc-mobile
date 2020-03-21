import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/data/model/login_response.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:hethongchamcong_mobile/screen/account/account_screen.dart';
import 'package:hethongchamcong_mobile/screen/cameracheckin/check_in_camera_screen.dart';
import 'package:hethongchamcong_mobile/screen/checkin/check_in_screen.dart';
import 'package:hethongchamcong_mobile/screen/complaint/complaint_screen.dart';
import 'package:hethongchamcong_mobile/screen/leaving/detail_leaving/detail_leaving.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_form/leaving_form.dart';
import 'package:hethongchamcong_mobile/screen/login/login_screen.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:hethongchamcong_mobile/screen/password/password_screen.dart';
import 'package:hethongchamcong_mobile/screen/switch_account/quick_login.dart';

import '../config/constant.dart';

class SlideCustomRoute<T> extends MaterialPageRoute<T> {
  final String routeName;

  SlideCustomRoute({WidgetBuilder builder, RouteSettings settings, this.routeName})
      : assert(routeName != null),
        super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;

    return new SlideTransition(
      position: new Tween(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(new CurvedAnimation(
        parent: animation,
        curve: Curves.ease,
      )),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}

SlideCustomRoute initialSlideRoutes(RouteSettings settings) {
  switch (settings.name) {
    case Constants.login_screen:
      return new SlideCustomRoute(
          builder: (_) => new LoginScreen(), settings: settings, routeName: Constants.login_screen);
    case Constants.home_screen:
      return new SlideCustomRoute(
          builder: (_) => new MainScreen(
                title: "Welcome to Flutter app",
              ),
          settings: settings,
          routeName: Constants.main_screen);
    case Constants.account_screen:
      return new SlideCustomRoute(
          builder: (_) => new AccountScreen(), settings: settings, routeName: Constants.main_screen);

    case Constants.check_in_screen:
      return new SlideCustomRoute(
          builder: (_) => new CheckInLocationPage(), settings: settings, routeName: Constants.check_in_screen);
    case Constants.check_in_camera_screen:
      return new SlideCustomRoute(
          builder: (_) => new CheckInCameraPage(), settings: settings, routeName: Constants.check_in_camera_screen);
    case Constants.password_screen:
      return new SlideCustomRoute(
          builder: (_) => new PasswordScreen(), settings: settings, routeName: Constants.password_screen);
    case Constants.leaving_form_screen:
      return new SlideCustomRoute(
          builder: (_) => new LeavingFormScreen(), settings: settings, routeName: Constants.leaving_form_screen);
    case Constants.complaint_screen:
      return new SlideCustomRoute(
          builder: (_) => new ComplaintScreen(), settings: settings, routeName: Constants.complaint_screen);
    case Constants.detail_leaving_screen:
      return new SlideCustomRoute(
          builder: (_) => new DetailLeavingScreen(
                listFormDate: settings.arguments as List<FormDate>,
              ),
          settings: settings,
          routeName: Constants.leaving_form_screen);
    case Constants.quick_login:
      return new SlideCustomRoute(
          builder: (_) => new QuickLogin(
                users: settings.arguments as List<UserData>,
              ),
          settings: settings,
          routeName: Constants.quick_login);
  }
  return new SlideCustomRoute(builder: (_) => LoginScreen(), settings: settings, routeName: Constants.login_screen);
}
