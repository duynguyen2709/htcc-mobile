import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/app_color.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/screen/login/login_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:mobx/mobx.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode focusNodeUserName = FocusNode();

  FocusNode focusNodePassword = FocusNode();

  FocusNode focusNodeCode = FocusNode();

  bool isShowPass = false;

  bool shouldNotFocus = false;

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController companyIdController = TextEditingController();

  FocusScopeNode currentFocus;

  ProgressDialog pr;

  LoginScreenStore loginScreenStore;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginScreenStore = LoginScreenStore();

    reaction((_) => loginScreenStore.checkLogin, (checkLogin) async {
      if (checkLogin == true) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool(Constants.IS_LOGIN, true);
        Navigator.pushReplacementNamed(context, Constants.home_screen);
      } else if (loginScreenStore.errorMessage != null && loginScreenStore.errorMessage.isNotEmpty)
        _showErrorDialog(loginScreenStore.errorMessage);
    });
  }

  void _login() async {
    loginScreenStore.login(userNameController.text, passwordController.text, companyIdController.text);
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
                shouldNotFocus = true;
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
            backgroundColor: Theme.of(context).backgroundColor,
            body: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: SingleChildScrollView(
                    physics: (MediaQuery.of(context).viewInsets.bottom == 0.0)
                        ? NeverScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: MediaQuery.of(context).size.height / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlutterLogo(
                                size: 100,
                              ),
                              Text("")
                            ],
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: TextFormField(
                                  controller: userNameController,
                                  focusNode: focusNodeUserName,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.mail),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Colors.red)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Color(AppColor.accentColor))),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                    labelText: Constants.hintUserName,
                                    hintStyle:
                                        focusNodeUserName.hasFocus ? TextStyle(color: Color(0x78b9eb)) : TextStyle(),
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return Constants.titleErrorUserName;
                                    }
                                    return null;
                                  },
                                ),
                                padding: EdgeInsets.only(bottom: 25),
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              ),
                              Container(
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: !isShowPass,
                                  focusNode: focusNodePassword,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: isShowPass
                                        ? GestureDetector(
                                            child: Icon(Icons.lock_open),
                                            onTap: () {
                                              setState(() {
                                                isShowPass = !isShowPass;
                                              });
                                            },
                                          )
                                        : GestureDetector(
                                            child: Icon(Icons.lock_outline),
                                            onTap: () {
                                              setState(() {
                                                isShowPass = !isShowPass;
                                              });
                                            },
                                          ),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Colors.red)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Color(AppColor.accentColor))),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                    labelText: Constants.hintPassword,
                                    hintStyle: focusNodePassword.hasFocus
                                        ? TextStyle(color: Color(AppColor.accentColor))
                                        : TextStyle(),
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return Constants.titleErrorPassword;
                                    }
                                    return null;
                                  },
                                ),
                                padding: EdgeInsets.only(bottom: 25),
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              ),
                              Container(
                                child: TextFormField(
                                  controller: companyIdController,
                                  focusNode: focusNodeCode,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.business_center),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Colors.red)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Color(AppColor.accentColor))),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                    labelText: Constants.code,
                                    hintStyle: focusNodeCode.hasFocus
                                        ? TextStyle(color: Color(AppColor.accentColor))
                                        : TextStyle(),
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return Constants.titleErrorCode;
                                    }
                                    return null;
                                  },
                                ),
                                padding: EdgeInsets.only(bottom: 25),
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                Constants.buttonLogin,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            onPressed: () {
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              if (_formKey.currentState.validate()) _login();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(320.0),
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        ),
                        Center(
                          child: Container(
                            width: 200,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: () {},
                              child: Text(
                                Constants.forgotPassword,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(AppColor.accentColor)),
                              ),
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    ),
                  ),
                ),
                Observer(builder: (_) {
                  if (loginScreenStore.isLoading)
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
                title: Text('Warning'),
                content: Text('Do you really want to exit'),
                actions: [
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () => exit(0),
                  ),
                  FlatButton(
                    child: Text('No'),
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
}
