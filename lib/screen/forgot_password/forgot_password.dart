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
//          Navigator.of(context).pushAndRemoveUntil(
//              MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
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
                                "Quên mật khẩu",
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
                              controller: codeController,
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
                                labelText: 'Mã công ty',
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
                              controller: usernameController,
                              focusNode: focusNodeUser,
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
                                labelText: 'Tên đăng nhập',
                                hintStyle: focusNodeUser.hasFocus ? TextStyle(color: Colors.blue) : TextStyle(),
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
                            'Xác nhận',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        onPressed: () {
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (_formKey.currentState.validate()) {
                            forgotPasswordStore.submit(codeController.text, usernameController.text);
                          }
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
              if (forgotPasswordStore.isLoading)
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
