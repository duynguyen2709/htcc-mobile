import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hethongchamcong_mobile/screen/checkin/check_in_screen.dart';

import 'account/account_screen.dart';

class MainScreen extends StatefulWidget {
  final String title;

  MainScreen({this.title});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  final _pageOptions = [
    CheckInLocationPage(  key: PageStorageKey('CheckInScreen'),),
    Center( child: Text("Leaving screen")),
    Center( child: Text("Statistic screen")),
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
      body:  IndexedStack(
        index: _selectedPage,
        children: _pageOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("./assets/checkin.png")),
              title: Text('Điểm danh')),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("./assets/leaving.png")),
              title: Text('Xin nghỉ phép')),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("./assets/statistics.png")),
              title: Text('Thống kê')),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("./assets/noti.png")),
              title: Text('Thông báo')),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              title: Text('Thêm')),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
