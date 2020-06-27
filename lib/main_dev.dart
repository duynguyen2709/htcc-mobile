import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hethongchamcong_mobile/config/app_color.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:hethongchamcong_mobile/route/route_controller.dart';
import 'package:hethongchamcong_mobile/screen/login/login_screen.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:hethongchamcong_mobile/utils/firebase_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/config.dart';
import 'config/inheritage_config.dart';
import 'data/model/login_response.dart';
import 'env/dev.dart';
import 'screen/quick_login/quick_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  bool isLogin = sharedPreferences.getBool(Constants.IS_LOGIN);

  String usersJson = sharedPreferences.getString(Constants.USERS);

  List<UserData> users;

  FireBaseNotifications.getInstance().setUpFirebase();

  if (usersJson != null && usersJson.isNotEmpty) {
    users = userDataFromJson(usersJson);
  }

  if (isLogin == null) isLogin = false;

  if (isLogin == true) {
    Injector.mainRepository.getCacheListScreen();
  }

  runApp(ConfigWrapper(
      config: Config.fromJson(config),
      child: new MyApp(
        isLogin: isLogin,
        users: users,
      )));
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  final List<UserData> users;

  MyApp({this.isLogin, this.users});

  @override
  Widget build(BuildContext context) {
    var config = ConfigWrapper.of(context);

    DioManager.setBaseUrl(config.baseURL);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: initialSlideRoutes,
      theme: ThemeData(
        backgroundColor: Colors.white,
        accentColor: Color(AppColor.accentColor),
      ),
      home: isLogin
          ? MainScreen()
          : ((users != null && users.length > 0)
              ? QuickLogin(
                  users: users,
                )
              : LoginScreen()),
    );
  }
}
