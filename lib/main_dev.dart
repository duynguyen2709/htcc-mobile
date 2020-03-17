import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/config/app_color.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:hethongchamcong_mobile/route/route_controller.dart';
import 'package:hethongchamcong_mobile/screen/login/login_screen.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/config.dart';
import 'config/inheritage_config.dart';
import 'env/dev.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isLogin = sharedPreferences.getBool(Constants.IS_LOGIN);
  if (isLogin == null) isLogin = false;
  runApp(ConfigWrapper(config: Config.fromJson(config), child: new MyApp(isLogin: isLogin,)));
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  MyApp({this.isLogin});

  @override
  Widget build(BuildContext context) {
    var config = ConfigWrapper.of(context);
    DioManager.setBaseUrl(config.baseURL);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: initialSlideRoutes,
      theme: ThemeData(
        backgroundColor: Colors.white,
        accentColor: Color(AppColor.accentColor),
      ),
      home: isLogin ? MainScreen() : LoginScreen(),
    );
  }
}
