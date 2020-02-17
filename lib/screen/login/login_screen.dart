import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  FocusNode focusNodeUserName = new FocusNode();
  FocusNode focusNodePassword = new FocusNode();
  FocusNode focusNodeCode = new FocusNode();
  ProgressDialog pr;
  LoginScreenStore loginScreenStore;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginScreenStore = LoginScreenStore();
    reaction((_) => loginScreenStore.checkLogin, (checkLogin) async {
      if (checkLogin == true) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool(Constants.IS_LOGIN, true);
        Navigator.pushReplacementNamed(context, Constants.home_screen);
      } else
        _showErrorDialog();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _login() async {
    loginScreenStore.login();
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Constants.titleErrorDialog),
          content: new Text(Constants.messageErrorDialog),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(Constants.buttonErrorDialog),
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
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    //Optional
    pr.style(
      message: Constants.loading,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.elasticIn,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 450,
                      height: MediaQuery.of(context).size.height/3,
                      child: Image.asset('assets/login_header.png',),
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              focusNode: focusNodeUserName,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(AppColor.accentColor))),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 14),
                                hintText: Constants.hintUserName,
                                hintStyle: focusNodeUserName.hasFocus
                                    ? TextStyle(color: Color(0x78b9eb))
                                    : TextStyle(),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return Constants.titleErrorUserName;
                                }
                                return null;
                              },
                            ),
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          ),
                          Container(
                            child: TextFormField(
                              obscureText: true,
                              focusNode: focusNodePassword,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(AppColor.accentColor))),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 14),
                                hintText: Constants.hintPassword,
                                hintStyle: focusNodePassword.hasFocus
                                    ? TextStyle(
                                        color: Color(AppColor.accentColor))
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
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          ),
                          Container(
                            child: TextFormField(
                              focusNode: focusNodeCode,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.business_center),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(AppColor.accentColor))),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 14),
                                hintText: Constants.code,
                                hintStyle: focusNodeCode.hasFocus
                                    ? TextStyle(
                                        color: Color(AppColor.accentColor))
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
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {},
                            child: Text(
                              Constants.forgotPassword,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Color(AppColor.accentColor)),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    ),
                    Container(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Color(AppColor.accentColor),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(Constants.buttonLogin),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) _login();
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(320.0),
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
        onWillPop: () => showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                title: Text('Warning'),
                content: Text('Do you really want to exit'),
                actions: [
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () => Navigator.pop(c, true),
                  ),
                  FlatButton(
                    child: Text('No'),
                    onPressed: () => Navigator.pop(c, false),
                  ),
                ],
              ),
            ));
  }
}
