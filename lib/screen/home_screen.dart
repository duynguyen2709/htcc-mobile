import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/widget/avatar_info_home.dart';
import 'package:hethongchamcong_mobile/widget/custom_section_home.dart';

import '../constant.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      body: SingleChildScrollView(
        child: Container(
          height: (MediaQuery.of(context).size.height),
          child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage('./assets/header.png'),
              ),
              Positioned(
                width: (MediaQuery.of(context).size.width),
                top: 20,
                child: AvatarInfoHome(),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height) / 3.5,
                child: Container(
                  width: (MediaQuery.of(context).size.width),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomSelectionHome(
                            title: "Điểm danh",
                            icon: Image(
                                height: 40,
                                width: 40,
                                image: AssetImage('./assets/checkin.png')),
                            route: Constants.check_in_screen,
                          ),
                          CustomSelectionHome(
                              title: "Bảng Lương",
                              icon: Image(
                                  height: 40,
                                  width: 40,
                                  image: AssetImage('./assets/payroll.png')),
                              route: Constants.check_in_screen),
                          CustomSelectionHome(
                              title: "Thống Kê",
                              icon: Image(
                                  height: 40,
                                  width: 40,
                                  image:
                                  AssetImage('./assets/statistics.png')),
                              route: Constants.check_in_screen),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomSelectionHome(
                              title: "Lich Sử Chấm Công",
                              icon: Image(
                                  height: 40,
                                  width: 40,
                                  image: AssetImage('./assets/history.png')),
                              route: Constants.check_in_screen),
                          CustomSelectionHome(
                              title: "Xin Nghỉ Phép",
                              icon: Image(
                                  height: 40,
                                  width: 40,
                                  image: AssetImage('./assets/leaving.png')),
                              route: Constants.check_in_screen),
                          CustomSelectionHome(
                              title: "Góp Ý - Khiếu Nại",
                              icon: Image(
                                  height: 40,
                                  width: 40,
                                  image: AssetImage('./assets/complaint.png')),
                              route: Constants.check_in_screen),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}