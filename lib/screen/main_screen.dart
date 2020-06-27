import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/screen.dart';
import 'package:hethongchamcong_mobile/screen/checkin/check_in_screen.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_screen.dart';
import 'package:hethongchamcong_mobile/screen/main_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/more/more_screen.dart';
import 'package:hethongchamcong_mobile/screen/notification/notification_screen.dart';
import 'package:hethongchamcong_mobile/utils/firebase_notifications.dart';

import 'statistic/statisic_screen.dart';

class MainScreen extends StatefulWidget {
  final String title;

  final int index;

  MainScreen({this.title, this.index = 0});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _selectedPage = 0;

  bool isHide = false;

  MainScreenStore mainScreenStore;

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
    WidgetsBinding.instance.addObserver(this);
    FireBaseNotifications.getInstance().firebaseCloudMessagingListeners(context);

    FireBaseNotifications.getInstance().shouldHandle = true;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _selectedPage = widget.index;

    mainScreenStore = MainScreenStore();

    FireBaseNotifications.getInstance().notifyStream.listen((int event) {
      mainScreenStore.getCountNotification();
    });
//    _pageOptions = [
//      CheckInLocationPage(
//        key: PageStorageKey('CheckInScreen'),
//        parent: this,
//      ),
//      LeavingScreen(
//        key: PageStorageKey('Leaving'),
//        parent: this,
//      ),
//      StatisticScreen(),
//      NotificationScreen(
//        mainScreenState: this,
//      ),
//      MoreScreen()
//    ];
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
//    FireBaseNotifications.getInstance().notifyStream.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      mainScreenStore.getCountNotification();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainScreenStore.getCountNotification();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.\
    List<Widget> _pageOptions = [];
    if (checkScreen(Constants.CHECKIN))
      _pageOptions.add(CheckInLocationPage(
        key: PageStorageKey('CheckInScreen'),
        parent: this,
      ));
    if (checkScreen(Constants.DAY_OFF))
      _pageOptions.add(LeavingScreen(
        key: PageStorageKey('Leaving'),
        parent: this,
      ));
    if (checkScreen(Constants.STATISTIC)) _pageOptions.add(StatisticScreen());
    _pageOptions.add(NotificationScreen(mainScreenState: this));
    _pageOptions.add(MoreScreen());
    return Scaffold(
        body: Stack(
      children: <Widget>[
        IndexedStack(
          index: _selectedPage,
          children: _pageOptions,
        ),
        !_keyboardIsVisible()
            ? Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: bottomNavigationBar,
              )
            : Container(),
      ],
    )
//      bottomNavigationBar: bottomNavigationBar, // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  void hideBottomNavigation() {
    setState(() {
      isHide = true;
    });
  }

  void showBottomNavigation() {
    setState(() {
      isHide = false;
    });
  }

  Widget get bottomNavigationBar {
    List<BottomNavigationBarItem> items = [];
    if (checkScreen(Constants.CHECKIN))
      items.add(BottomNavigationBarItem(icon: ImageIcon(AssetImage("./assets/checkin.png")), title: Text('Điểm danh')));
    if (checkScreen(Constants.DAY_OFF))
      items.add(
        BottomNavigationBarItem(icon: ImageIcon(AssetImage("./assets/leaving.png")), title: Text('Xin nghỉ phép')),
      );
    if (checkScreen(Constants.STATISTIC))
      items.add(
        BottomNavigationBarItem(icon: ImageIcon(AssetImage("./assets/statistics.png")), title: Text('Thống kê')),
      );
    items.addAll([
      BottomNavigationBarItem(
        icon: Observer(
          builder: (BuildContext context) {
            return (mainScreenStore.number > 0)
                ? Badge(
                    badgeContent: Text(
                      mainScreenStore.number.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    child: ImageIcon(AssetImage("./assets/noti.png")),
                  )
                : ImageIcon(AssetImage("./assets/noti.png"));
          },
        ),
        title: Text('Thông báo'),
      ),
      BottomNavigationBarItem(icon: Icon(Icons.more_horiz), title: Text('Thêm')),
    ]);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xEef7f7f7).withBlue(130),
        borderRadius:
            new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0)),
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
        borderRadius: BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0)),
        child: BottomNavigationBar(
          elevation: 100,
          type: BottomNavigationBarType.shifting,
          items: items,
//          items: [
//            BottomNavigationBarItem(icon: ImageIcon(AssetImage("./assets/checkin.png")), title: Text('Điểm danh')),
//            BottomNavigationBarItem(icon: ImageIcon(AssetImage("./assets/leaving.png")), title: Text('Xin nghỉ phép')),
//            BottomNavigationBarItem(icon: ImageIcon(AssetImage("./assets/statistics.png")), title: Text('Thống kê')),
//            BottomNavigationBarItem(
//              icon: Observer(
//                builder: (BuildContext context) {
//                  return (mainScreenStore.number > 0)
//                      ? Badge(
//                          badgeContent: Text(
//                            mainScreenStore.number.toString(),
//                            style: TextStyle(color: Colors.white, fontSize: 12),
//                          ),
//                          child: ImageIcon(AssetImage("./assets/noti.png")),
//                        )
//                      : ImageIcon(AssetImage("./assets/noti.png"));
//                },
//              ),
//              title: Text('Thông báo'),
//            ),
//            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), title: Text('Thêm')),
//          ],
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedPage,
          onTap: (int index) {
            if (index != 0) {
              Future.delayed(Duration(milliseconds: 100), () {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
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

  setSelectedPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
