import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/screen/dialog/app_dialog.dart';
import 'package:hethongchamcong_mobile/screen/forgot_password/forgot_password_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:mobx/mobx.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ForgotPasswordStore forgotPasswordStore;

  FocusScopeNode currentFocus;

  TextEditingController codeController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  FocusNode focusNodeCode = FocusNode();

  FocusNode focusNodeUser = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    forgotPasswordStore = ForgotPasswordStore();
    reaction((_) => forgotPasswordStore.msg, (String msg) {
      if (msg != '') {
        AppDialog.showDialogNotify(context, msg, () {
          while(Navigator.of(context).canPop()){
            Navigator.of(context).pop();
          }
        });
      }
      ;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentFocus = FocusScope.of(context);
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
                            "Quên mật khẩu",
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
                                    controller: codeController,
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
                                    controller: usernameController,
                                    focusNode: focusNodeUser,
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
                              ],
                            ),
                          ),
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
                                "Xác nhận",
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
                            if (_formKey.currentState.validate()) forgotPasswordStore.submit(codeController.text, usernameController.text);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Observer(builder: (_) {
              if (forgotPasswordStore.isLoading)
                return LoadingScreen();
              else
                return Center();
            }),
          ],
        ),
      )
    );
  }
}
