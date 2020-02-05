import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/screen/account_screen.dart';
import '../constant.dart';
import 'package:hethongchamcong_mobile/screen/login_screen.dart';
import 'package:hethongchamcong_mobile/screen/home_screen.dart';

class SlideCustomRoute<T> extends MaterialPageRoute<T> {
  final String routeName;

  SlideCustomRoute(
      {WidgetBuilder builder, RouteSettings settings, this.routeName})
      : assert(routeName != null),
        super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
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
          builder: (_) => new LoginScreen(),
          settings: settings,
          routeName: Constants.login_screen);
    case Constants.main_screen:
      return new SlideCustomRoute(
          builder: (_) => new HomeScreen(
                title: "Welcome to Flutter app",
              ),
          settings: settings,
          routeName: Constants.main_screen);
    case Constants.account_screen:
      return new SlideCustomRoute(
          builder: (_) => new AccountScreen(),
          settings: settings,
          routeName: Constants.main_screen);
  }
  return new SlideCustomRoute(
      builder: (_) => new LoginScreen(),
      settings: settings,
      routeName: Constants.login_screen);
}
