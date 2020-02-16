import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hethongchamcong_mobile/model/account.dart';
import 'package:hethongchamcong_mobile/screen/account_screen.dart';
import 'package:hethongchamcong_mobile/screen/check_in_screen.dart';
import 'package:hethongchamcong_mobile/screen/home_screen.dart';
import 'package:hethongchamcong_mobile/widget/avatar_info_home.dart';
import 'package:hethongchamcong_mobile/widget/custom_section_home.dart';

import '../constant.dart';

class MainScreen extends StatefulWidget {
  final String title;

  MainScreen({this.title});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;
  AccountModel _accountModel;
  final PageStorageBucket bucket = PageStorageBucket();
  final _pageOptions = [
    CheckInLocationPage(  key: PageStorageKey('CheckInScreen'),),
    Center( child: Text("Notification screen")),
    AccountScreen()
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      body:  IndexedStack(
        index: _selectedPage,
        children: _pageOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("./assets/home.png")),
              title: Text('Trang chủ', style: TextStyle(fontSize: 12))),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("./assets/noti.png")),
              title: Text('Thông báo')),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("./assets/personal.png")),
              title: Text('Cá nhân')),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
