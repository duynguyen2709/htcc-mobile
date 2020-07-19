import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/screen/dialog/app_dialog.dart';
import 'package:hethongchamcong_mobile/screen/password/password_screen_store.dart';
import 'package:mobx/mobx.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

enum PasswordError { EMPTY, SHORT, INVALID, VALID, NOT_EQUAL }

const Map<PasswordError, String> errorMessage = {
  PasswordError.EMPTY: "Vui lòng nhập mật khẩu.",
  PasswordError.SHORT: "Mật khẩu phải có ít nhất 8 kí tự.",
  PasswordError.INVALID:
      "Mật khẩu không hợp lệ. Mật khẩu phải có ít nhất 1 kí tự a-z, A-Z, 0-9.",
  PasswordError.NOT_EQUAL: "Mật khẩu nhập lại không khớp.",
  PasswordError.VALID: "",
};

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController _oldPasswordController;
  TextEditingController _newPasswordController;
  TextEditingController _repeatController;
  bool _oldPasswordVisible = true;
  bool _newPasswordVisible = true;
  bool _repeatVisible = true;
  PasswordScreenStore passwordScreenStore;
  PasswordError errorMsgOldPass, errorMsgNewPass, errorMsgRetypePass;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _repeatController = TextEditingController();
    passwordScreenStore = PasswordScreenStore();
    errorMsgNewPass = PasswordError.VALID;
    errorMsgOldPass = PasswordError.VALID;
    errorMsgRetypePass = PasswordError.VALID;
    reaction((_) => passwordScreenStore.isSuccess, (isSuccess) async {
      if (isSuccess == true) {
        _showDialog(false, "Đổi mật khẩu thành công.");
      } else if (isSuccess != null) {
        if (passwordScreenStore.errorAuth!=null) {
          _showDialog(true, passwordScreenStore.errorMessage);
        } else {
          _showDialog(false, passwordScreenStore.errorMessage);
        }
      }
    });
  }

  void _showDialog(bool isAuthErr, String msg) {
    AppDialog.showDialogNotify(context, msg, (){
      if (isAuthErr)
        Navigator.pushReplacementNamed(
            context, Constants.login_screen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đổi mật khẩu"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blueAccent,
                              Colors.blue,
                              Colors.lightBlue,
                              Colors.lightBlueAccent
                            ]),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
                            child: TextFormField(
                              controller: _oldPasswordController,
                              obscureText: _oldPasswordVisible,
                              cursorColor: Colors.white,
                              style: TextStyle(fontSize: 18, color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1
                                ),),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                hintText: 'Mật khẩu cũ',
                                hintStyle: TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _oldPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: _oldPasswordVisible
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _oldPasswordVisible =
                                          !_oldPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          errorMsgOldPass != PasswordError.VALID
                              ? Text(
                                  errorMessage[errorMsgOldPass],
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              : Container(),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
                            child: TextFormField(
                              controller: _newPasswordController,
                              obscureText: _newPasswordVisible,
                              cursorColor: Colors.white,
                              style: TextStyle(fontSize: 18, color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1
                                ),),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                hintText: 'Mật khẩu mới',
                                hintStyle: TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _newPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: _newPasswordVisible
                                        ?  Colors.white
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _newPasswordVisible = !_newPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          errorMsgNewPass != PasswordError.VALID
                              ? Text(
                                  errorMessage[errorMsgNewPass],
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              : Container(),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
                            child: TextFormField(
                              controller: _repeatController,
                              obscureText: _repeatVisible,
                              cursorColor: Colors.white,
                              style: TextStyle(fontSize: 18, color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1
                                ),),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                hintText: 'Nhập lại mật khẩu mới',
                                hintStyle: TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _repeatVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: _repeatVisible
                                        ?  Colors.white
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _repeatVisible = !_repeatVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          errorMsgRetypePass != PasswordError.VALID
                              ? Text(
                                  errorMessage[errorMsgRetypePass],
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              : Container(),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                      onPressed: () {
                        // ignore: unnecessary_statements
                        _validate() ? _changePassword() : null;
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.white)),
                      child: Text(
                        "Thay đổi mật khấu",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Observer(builder: (_) {
              if (passwordScreenStore.isLoading)
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black45,
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                );
              else
                return Center();
            }),
          ],
        ),
      ),
    );
  }

  _changePassword() async {
    passwordScreenStore.changePassword(
      _repeatController.text,
      _oldPasswordController.text,
    );
  }

  bool validatePasswordStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool _validate() {
    PasswordError err1, err2, err3;
    err1 = PasswordError.VALID;
    err2 = PasswordError.VALID;
    err3 = PasswordError.VALID;
    if (_oldPasswordController.text == "") {
      err1 = PasswordError.EMPTY;
    } else if (_oldPasswordController.text.length < 8) {
      err1 = PasswordError.SHORT;
    } else if (!validatePasswordStructure(_oldPasswordController.text)) {
      err1 = PasswordError.INVALID;
    }
    if (_newPasswordController.text == "") {
      err2 = PasswordError.EMPTY;
    } else if (_newPasswordController.text.length < 8) {
      err2 = PasswordError.SHORT;
    } else if (!validatePasswordStructure(_newPasswordController.text)) {
      err2 = PasswordError.INVALID;
    }
    if (_repeatController.text == "") {
      err3 = PasswordError.EMPTY;
    } else if (_repeatController.text.length < 8) {
      err3 = PasswordError.SHORT;
    } else if (!validatePasswordStructure(_repeatController.text)) {
      err3 = PasswordError.INVALID;
    }
    if (_repeatController.text.compareTo(_newPasswordController.text) != 0) {
      err3 = PasswordError.NOT_EQUAL;
    }
    setState(() {
      errorMsgOldPass = err1;
      errorMsgNewPass = err2;
      errorMsgRetypePass = err3;
    });
    if (err1 != PasswordError.VALID ||
        err2 != PasswordError.VALID ||
        err3 != PasswordError.VALID) {
      return false;
    } else
      return true;
  }
}
