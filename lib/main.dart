import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hethongchamcong_mobile/route/route_controller.dart';
import 'package:hethongchamcong_mobile/screen/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent ,
    statusBarBrightness: Brightness.light,
  ));
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: initialSlideRoutes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
