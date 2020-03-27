import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hethongchamcong_mobile/screen/checkin/check_in_screen.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_screen.dart';
import 'package:hethongchamcong_mobile/screen/more/more_screen.dart';
import 'package:hethongchamcong_mobile/screen/notification/notification_screen.dart';
import 'statistic/statisic_screen.dart';

class MainScreen extends StatefulWidget {
  final String title;

  MainScreen({this.title});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;

//  final _pageOptions = [
//    CheckInLocationPage(
//      key: PageStorageKey('CheckInScreen'),
//      parent: this,
//    ),
//    Center(child: LeavingScreen(key: PageStorageKey('Leaving'))),
//    StatisticScreen(),
//    NotificationScreen(),
//    MoreScreen()
//  ];

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
    var _pageOptions = [
      CheckInLocationPage(
        key: PageStorageKey('CheckInScreen'),
        parent: this,
      ),
      LeavingScreen(key: PageStorageKey('Leaving')),
      StatisticScreen(),
      NotificationScreen(),
      MoreScreen()
    ];
    return Scaffold(
        body: Stack(
          children: <Widget>[
            IndexedStack(
              index: _selectedPage,
              children: _pageOptions,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: bottomNavigationBar,
            ),
          ],
        )
//      bottomNavigationBar: bottomNavigationBar, // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget get bottomNavigationBar {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xEef7f7f7).withBlue(130),
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 5.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0)),
        child: BottomNavigationBar(
          elevation: 100,
          type: BottomNavigationBarType.shifting,
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
                icon: Icon(Icons.more_horiz), title: Text('Thêm')),
          ],
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedPage,
          onTap: (int index) {
            if (index != 0) {
              Future.delayed(Duration(milliseconds: 100), () {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarColor: Colors.blue, // status bar color
                ));
              });
            }
            setState(() {
              _selectedPage = index;
            });
          },
        ),
      ),
    );
  }

  int getSelectedIndex() => _selectedPage;
}
