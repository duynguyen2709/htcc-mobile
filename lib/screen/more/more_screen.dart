import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import '../widget/section.dart';
import 'package:hethongchamcong_mobile/widget/avatar_info_home.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xEEEEEEEE),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blueAccent,
                            Colors.blue,
                            Colors.lightBlue,
                            Colors.lightBlueAccent
                          ]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                ),
                Center(
                    child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 12),
                        child: AvatarInfoHome())),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              decoration: new BoxDecoration(
                  color: Colors.white, //n
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ], // ew Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Section(
                      leading: Icon(Icons.person),
                      title: "Thông tin cá nhân",
                      following: true,
                      onTap: () => {
                            Navigator.pushNamed(
                                context, Constants.account_screen)
                          }),
                  Section(
                      leading: Icon(Icons.lock_outline),
                      title: "Đổi mật khẩu",
                      following: true,
                      onTap: () => {
                        Navigator.pushNamed(
                            context, Constants.account_screen)
                      }),
                  ListTile(
                      title: Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                      ),
                      Icon(Icons.contacts),
                      Container(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        "Danh bạ công ty",
                        style: TextStyle(fontSize: 18),
                      )),
                    ],
                  )),
                  ListTile(
                      title: Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                      ),
                      ImageIcon(AssetImage("./assets/payroll.png")),
                      Container(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        "Quản lý bảng lương",
                        style: TextStyle(fontSize: 18),
                      )),
                    ],
                  )),
                  ListTile(
                      title: Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                      ),
                      ImageIcon(AssetImage("./assets/complaint.png")),
                      Container(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        "Góp ý - Khiếu nại",
                        style: TextStyle(fontSize: 18),
                      )),
                    ],
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              decoration: new BoxDecoration(
                  color: Colors.white, //n
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ], // ew Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ListTile(
                      title: Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                      ),
                      Icon(Icons.info_outline),
                      Container(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        "Về ứng dụng",
                        style: TextStyle(fontSize: 18),
                      )),
                    ],
                  )),
                  ListTile(
                      title: Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                      ),
                      Icon(Icons.exit_to_app),
                      Container(
                        width: 20,
                      ),
                      Expanded(
                          child: Text(
                        "Đăng xuất",
                        style: TextStyle(fontSize: 18),
                      )),
                    ],
                  )),
                ],
              ),
            ),
            Container(
              height: 60,
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
