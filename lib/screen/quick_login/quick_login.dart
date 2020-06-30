import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/login_response.dart';
import 'package:hethongchamcong_mobile/screen/quick_login/quick_login_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:mobx/mobx.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuickLogin extends StatefulWidget {
  QuickLogin({this.users});

  final List<UserData> users;

  @override
  _QuickLoginState createState() => _QuickLoginState();
}

class _QuickLoginState extends State<QuickLogin> {
  QuickLoginStore quickLoginStore;

  ProgressDialog pr;

  FocusScopeNode currentFocus;

  @override
  void initState() {
    super.initState();

    quickLoginStore = QuickLoginStore();

    reaction((_) => quickLoginStore.checkLogin, (checkLogin) async {
      if (checkLogin == true) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool(Constants.IS_LOGIN, true);
        Navigator.pushReplacementNamed(context, Constants.home_screen);
      } else if (quickLoginStore.errorMessage != null && quickLoginStore.errorMessage.isNotEmpty)
        _showErrorDialog(quickLoginStore.errorMessage);
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(Constants.titleErrorDialog),
          content: Text(errorMessage),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(Constants.buttonErrorDialog),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    currentFocus = FocusScope.of(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    pr = ProgressDialog(context, type: ProgressDialogType.Normal);

    //Optional
    pr.style(
      message: Constants.loading,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.elasticIn,
      progressTextStyle: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return SafeArea(
      child: WillPopScope(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset("assets/bg_login.png"),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Danh sách tài khoản",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                itemCount: widget.users.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index != widget.users.length)
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                      ),
                                      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                      child: Material(
                                        child: InkWell(
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10, bottom: 10),
                                            height: 70,
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(100.0),
                                                      child: FadeInImage.assetNetwork(
                                                        placeholder: 'assets/gif/loading.gif',
                                                        image: widget.users[index].user.avatar,
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                                  color: Colors.grey,
                                                  width: 1,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(left: 24),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                          widget.users[index].user.companyId,
                                                          style: TextStyle(
                                                              color: Colors.black87,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          textAlign: TextAlign.start,
                                                        ),
                                                        Text(
                                                          widget.users[index].user.username,
                                                          style: TextStyle(
                                                              color: Colors.black87,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                _buildPopupMenu(widget.users[index]),
                                                SizedBox(
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            quickLoginStore.login(widget.users[index].user.username,
                                                widget.users[index].password, widget.users[index].user.companyId);
                                          },
                                        ),
                                        color: Colors.transparent,
                                      ),
                                    );
                                  else
                                    return Container(
                                      decoration: BoxDecoration(border: Border(top: BorderSide())),
                                      margin: EdgeInsets.only(top: 20),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, Constants.login_screen);
                                        },
                                        child: Container(
                                          height: 50,
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Icon(
                                                Icons.add_box,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Đăng nhập bằng tài khoản khác",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Observer(builder: (_) {
                  if (quickLoginStore.isLoading)
                    return LoadingScreen();
                  else
                    return Center();
                }),
              ],
            ),
          ),
          onWillPop: () {
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            return showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                title: Text('Thông báo'),
                content: Text('Bạn có muốn thoát khỏi ứng dụng?'),
                actions: [
                  FlatButton(
                    child: Text('Có'),
                    onPressed: () => exit(0),
                  ),
                  FlatButton(
                    child: Text('Không'),
                    onPressed: () {
                      Navigator.pop(c, false);
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _buildPopupMenu(UserData userData) {
    return PopupMenuButton<int>(
      onSelected: (int result) async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        widget.users.remove(userData);

        sharedPreferences.setString(Constants.USERS, userDataToJson(widget.users));

        if (widget.users.length == 0)
          Navigator.pushReplacementNamed(context, Constants.login_screen);
        else {
          setState(() {});
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Gỡ tài khoản khỏi thiết bị'),
        ),
      ],
    );
  }
}
