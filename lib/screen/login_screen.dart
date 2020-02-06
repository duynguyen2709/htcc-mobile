
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/constant.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode focusNodeUserName = new FocusNode();
  FocusNode focusNodePassword = new FocusNode();
  FocusNode focusNodeCode = new FocusNode();
  ProgressDialog pr;

  void _login() async {
    Navigator.pushReplacementNamed(context, Constants.home_screen);
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setString(Constants.isLogin, "true");
      _showLoadingDialog();
      Future.delayed(Duration(seconds: 2)).then((onValue){
        print("PR status  ${pr.isShowing()}" );
        if(pr.isShowing())
          pr.hide();
        print("PR status  ${pr.isShowing()}" );
        _showErrorDialog();

      });


//      _showNoNetworkDialog();
  }

  void register(){
    Navigator.pushReplacementNamed(context, Constants.register_screen);
  }

  void _showLoadingDialog() {
    pr.show();
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
      },);

  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: 450,
              height: 250,
              child: Image(
                image: AssetImage('assets/login_header.jpg'),
              ),
              margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
            ),
            Container(
              child: TextFormField(
                focusNode: focusNodeUserName,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Color(0xff00b0e3))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  hintText: Constants.hintUserName,
                  hintStyle: focusNodeUserName.hasFocus
                      ? TextStyle(color: Color(0xff00b0e3))
                      : TextStyle(),
                  filled: true,
                ),
              ),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            ),
            Container(
              child: TextFormField(
                obscureText: true,
                focusNode: focusNodePassword,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Color(0xff00b0e3))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  hintText: Constants.hintPassword,
                  hintStyle: focusNodePassword.hasFocus
                      ? TextStyle(color: Color(0xff00b0e3))
                      : TextStyle(),
                  filled: true,
                ),
              ),
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            ),
            Container(
              child: TextFormField(
                focusNode: focusNodeCode,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.business_center),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Color(0xff00b0e3))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  hintText: Constants.code,
                  hintStyle: focusNodeCode.hasFocus
                      ? TextStyle(color: Color(0xff00b0e3))
                      : TextStyle(),
                  filled: true,
                ),
              ),
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: (){

                    },
                    child: Text(
                      Constants.forgotPassword,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xff00b0e3)),
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
                color: Color(0xff00b0e3),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(Constants.buttonLogin),
                ),
                onPressed: () {
                  _login();
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
    );
  }
}
