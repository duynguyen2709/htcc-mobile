import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/login_response.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:hethongchamcong_mobile/widget/avatar_info_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/section.dart';

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
                          colors: [Colors.blueAccent, Colors.blue, Colors.lightBlue, Colors.lightBlueAccent]),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                ),
                Center(
                    child: Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 12),
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
                  borderRadius: new BorderRadius.all(const Radius.circular(10.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Section(
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      title: "Thông tin cá nhân",
                      following: true,
                      onTap: () => {Navigator.pushNamed(context, Constants.account_screen)}),
                  Section(
                      leading: Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                      ),
                      title: "Đổi mật khẩu",
                      following: false,
                      onTap: () => {Navigator.pushNamed(context, Constants.password_screen)}),
                  Section(
                      leading: Icon(
                        Icons.contacts,
                        color: Colors.black,
                      ),
                      title: "Danh bạ công ty",
                      following: false,
                      onTap: () => {Navigator.pushNamed(context, Constants.account_screen)}),
                  Section(
                      leading: ImageIcon(
                        AssetImage("./assets/payroll.png"),
                        color: Colors.black,
                      ),
                      title: "Quản lý bảng lương",
                      following: false,
                      onTap: () => {Navigator.pushNamed(context, Constants.account_screen)}),
                  Section(
                      leading: ImageIcon(
                        AssetImage("./assets/complaint.png"),
                        color: Colors.black,
                      ),
                      title: "Góp ý - Khiếu nại",
                      following: false,
                      onTap: () => {Navigator.pushNamed(context, Constants.account_screen)}),
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
                  borderRadius: new BorderRadius.all(const Radius.circular(10.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Section(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.black,
                      ),
                      title: "Về ứng dụng",
                      following: false,
                      onTap: () => {Navigator.pushNamed(context, Constants.account_screen)}),
                  Section(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      title: "Đăng xuất",
                      following: false,
                      onTap: () async {
                        Injector.authRepository.logout();

                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                        String usersJson = sharedPreferences.getString(Constants.USERS);

                        List<UserData> users;

                        if (usersJson != null && usersJson.isNotEmpty) {
                          users = userDataFromJson(usersJson);
                        }
                        if (users != null && users.isNotEmpty)
                          Navigator.pushReplacementNamed(context, Constants.quick_login, arguments: users);
                        else
                          Navigator.pushReplacementNamed(context, Constants.login_screen);
//                        Navigator.pushNamed(
//                            context, Constants.account_screen)
                      }),
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
