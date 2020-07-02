import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/screen/dialog/app_dialog.dart';
import 'package:hethongchamcong_mobile/screen/forgot_password/forgot_password.dart';
import 'package:hethongchamcong_mobile/screen/login/login_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:mobx/mobx.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
        Navigator.pushNamedAndRemoveUntil(context, Constants.home_screen, (Route<dynamic> route) => false);
      } else if (loginScreenStore.errorMessage != null && loginScreenStore.errorMessage.isNotEmpty){
        AppDialog.showDialogNotify(context,loginScreenStore.errorMessage , (){
          shouldNotFocus = true;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _login() async {
    loginScreenStore.login(userNameController.text, passwordController.text, companyIdController.text);
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
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      Image.asset("assets/bg_login.png"),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child:  Text(
                            "Đăng nhập",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.transparent,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                                  child: TextFormField(
                                    controller: companyIdController,
                                    focusNode: focusNodeCode,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(borderSide: BorderSide(
                                          color: Colors.grey[100],
                                          width: 0.5
                                      ),),
                                      hintText: "Mã công ty",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return Constants.titleErrorCode;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                                  child: TextFormField(
                                    controller: userNameController,
                                    focusNode: focusNodeUserName,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(borderSide: BorderSide(
                                            color: Colors.grey[100],
                                            width: 0.5
                                        ),),
                                        hintText: "Tên đăng nhập",
                                        hintStyle: TextStyle(color: Colors.grey)),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return Constants.titleErrorUserName;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: !isShowPass,
                                    focusNode: focusNodePassword,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return Constants.titleErrorPassword;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(borderSide: BorderSide(
                                          color: Colors.grey[100],
                                          width: 0.5
                                      ),),
                                      hintText: "Mật khẩu",
                                      hintStyle: TextStyle(color: Colors.grey),
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
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Quên mật khẩu?",
                              style: TextStyle(
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (BuildContext context) => ForgotPassword()));
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (_formKey.currentState.validate()) _login();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Center(
                            child: InkWell(
                              child: Container(
                                child: Text(
                                  "Đăng ký trải nghiệm",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.blueAccent))
                                ),
                              ),
                              onTap: (){
                                launch('https://home.1612145.online/');
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
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
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
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
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.blue, Colors.blue[700]]),
                      ),
                      width: 200,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              padding: EdgeInsets.all(10),
                              child: Image(image: AssetImage('assets/ic_launcher_round.png')),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              controller: companyIdController,
                              focusNode: focusNodeCode,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.business_center),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red, width: 2)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.black, width: 2)),
                                contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                labelText: Constants.code,
                                hintStyle: focusNodeCode.hasFocus ? TextStyle(color: Colors.blue) : TextStyle(),
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
                          Container(
                            child: TextFormField(
                              controller: userNameController,
                              focusNode: focusNodeUserName,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.mail),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red, width: 2)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.black, width: 2)),
                                contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                labelText: Constants.hintUserName,
                                hintStyle: focusNodeUserName.hasFocus ? TextStyle(color: Color(0x78b9eb)) : TextStyle(),
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
                                    borderSide: BorderSide(color: Colors.red, width: 2)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.red, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.black, width: 2)),
                                contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                labelText: Constants.hintPassword,
                                hintStyle: focusNodePassword.hasFocus ? TextStyle(color: Colors.blue) : TextStyle(),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return Constants.titleErrorPassword;
                                }
                                return null;
                              },
                            ),
                            padding: EdgeInsets.only(bottom: 10),
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (BuildContext context) => ForgotPassword()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              Constants.forgotPassword,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
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
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
    );
  }
}
