import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/config/app_color.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/route/route_controller.dart';
import 'package:hethongchamcong_mobile/screen/account/account_screen.dart';
import 'package:hethongchamcong_mobile/screen/home_screen.dart';
import 'package:hethongchamcong_mobile/screen/login/login_screen.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isLogin = sharedPreferences.getBool(Constants.IS_LOGIN);
  if (isLogin == null) isLogin = false;
  runApp(MyApp(
    isLogin: isLogin,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  MyApp({this.isLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: initialSlideRoutes,
      theme: ThemeData(
        backgroundColor: Colors.grey,
        accentColor: Color(AppColor.accentColor),
      ),
      home: isLogin ? MainScreen() : LoginScreen(),
    );
  }
}
