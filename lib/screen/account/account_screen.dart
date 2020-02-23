import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/account/model/AccountResponse.dart';
import 'package:hethongchamcong_mobile/screen/account/account_screen_store.dart';
import 'package:mobx/mobx.dart';
import 'package:shimmer/shimmer.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountScreenState();
  }
}

class _AccountScreenState extends State<AccountScreen> {
  AccountScreenStore accountScreenStore;

  // Controller TextField
  TextEditingController _controller1;
  TextEditingController _controller2;
  TextEditingController _controller3;
  TextEditingController _controller4;

  @override
  void initState() {
    super.initState();
    accountScreenStore = AccountScreenStore();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    accountScreenStore.getAccount();
    reaction((_) => accountScreenStore.accountData, (AccountData data) {
      if (data != null) {
        _controller1.text = data.gender;
        _controller2.text = data.age;
        _controller3.text = data.city;
        _controller4.text = data.age;
      } else {}
    });

    reaction((_) => accountScreenStore.error, (bool error) {
      if (error) {
        _showErrorDialog();
        accountScreenStore.error = false;
      }
    });
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                color: Colors.blue,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/login_header.png')),
              )
            ],
          ),
          Observer(
            builder: (_) {
              if (accountScreenStore.isLoading) {
                return _buildLoading();
              } else {
                return _buildSuccess(accountScreenStore.accountData);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              leading: IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, Constants.login_screen),
              ),
              backgroundColor: Colors.blue,
              title: Text(Constants.titleAppBarAccountScreen),
              centerTitle: true,
              actions: <Widget>[],
            ),
            Shimmer.fromColors(
                child: Container(
                  width: 90,
                  height: 90,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.white),
            Shimmer.fromColors(
                child: Container(
                  width: 150,
                  height: 20,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.white),
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.white),
            Shimmer.fromColors(
                child: Container(
                  width: 150,
                  height: 20,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.white),
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.white),
            Container(
              decoration: new BoxDecoration(
                  color: Colors.white, //n
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ], // ew Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0))),
              height: 200,
              width: MediaQuery.of(context).size.width * 6 / 7,
              alignment: Alignment.center,
              child: Padding(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                        title: Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                        ),
                        Icon(Icons.account_box),
                        Container(
                          width: 20,
                        ),
                        Expanded(child: Text("Gender")),
                        Shimmer.fromColors(
                            child: Container(
                              color: Colors.red,
                              width: 40,
                              height: 15,
                            ),
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.white),
                        Container(
                          width: 40,
                        ),
                      ],
                    )),
                    ListTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                          ),
                          Icon(Icons.account_box),
                          Container(
                            width: 20,
                          ),
                          Expanded(child: Text("Age")),
                          Shimmer.fromColors(
                              child: Container(
                                color: Colors.red,
                                width: 40,
                                height: 15,
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                          Container(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                          ),
                          Icon(Icons.account_box),
                          Container(
                            width: 20,
                          ),
                          Expanded(child: Text("City")),
                          Shimmer.fromColors(
                              child: Container(
                                color: Colors.red,
                                width: 40,
                                height: 15,
                              ),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white),
                          Container(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
              ),
            ),
            Container(
              height: 40,
            ),
            Container(
              decoration: new BoxDecoration(
                  color: Colors.white, //n
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ], // ew Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0))),
              height: 75,
              width: MediaQuery.of(context).size.width * 6 / 7,
              child: Padding(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                        title: Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                        ),
                        Icon(Icons.account_box),
                        Container(
                          width: 20,
                        ),
                        Expanded(child: Text("Note")),
                        Shimmer.fromColors(
                            child: Container(
                              color: Colors.red,
                              width: 40,
                              height: 15,
                            ),
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.white),
                        Container(
                          width: 40,
                        ),
                      ],
                    )),
                  ],
                ),
                padding: EdgeInsets.all(10),
              ),
            ),
            Container(
              height: 40,
            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
//                RaisedButton(
//                  textColor: Color(AppColor.accentColor),
//                  color: Colors.white,
//                  child: Padding(
//                    padding: const EdgeInsets.all(20),
//                    child: Text(Constants.buttonCancel),
//                  ),
//                  onPressed: () {},
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(18.0),
//                      side: BorderSide(
//                          color: Color(AppColor.accentColor), width: 5)),
//                ),
//                RaisedButton(
//                  textColor: Colors.white,
//                  color: Color(AppColor.accentColor),
//                  child: Padding(
//                    padding: const EdgeInsets.all(20),
//                    child: Text(Constants.buttonSave),
//                  ),
//                  onPressed: () {},
//                  shape: RoundedRectangleBorder(
//                      borderRadius: new BorderRadius.circular(18.0),
//                      side: BorderSide(
//                          color: Color(AppColor.accentColor), width: 5)),
//                ),
//              ],
//            )
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(AccountData account) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              AppBar(
                leading: IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context)
                ),
                backgroundColor: Colors.blue,
                title: Text(Constants.titleAppBarAccountScreen),
                centerTitle: true,
                actions: <Widget>[
                  Observer(
                      builder: (BuildContext context) => (accountScreenStore
                                  .edit ==
                              false)
                          ? IconButton(
                              icon: new Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                accountScreenStore.edit = true;
                              },
                            )
                          : IconButton(
                              icon: new Icon(Icons.check, color: Colors.white),
                              onPressed: () {},
                            ))
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: 90,
                height: 90,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/login_header.png',
                      image: account.linkAvatar,
                      fit: BoxFit.cover,
                    )),
              ),
              Text(
                account.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                Constants.phone + account.phone,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: new BoxDecoration(
                    color: Colors.white, //n
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ], // ew Color.fromRGBO(255, 0, 0, 0.0),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(10.0))),
                height: MediaQuery.of(context).size.height * 2 / 7,
                width: MediaQuery.of(context).size.width * 6 / 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ListTile(
                        title: Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                        ),
                        Icon(Icons.account_box),
                        Container(
                          width: 20,
                        ),
                        Expanded(child: Text("Gender")),
                        Observer(
                            builder: (BuildContext context) => Expanded(
                                    child: TextField(
                                  enabled: accountScreenStore.edit,
                                  controller: _controller1,
                                  textAlign: TextAlign.center,
                                ))),
                        Container(
                          width: 40,
                        ),
                      ],
                    )),
                    ListTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                          ),
                          Icon(Icons.account_box),
                          Container(
                            width: 20,
                          ),
                          Expanded(child: Text("Age")),
                          Observer(
                              builder: (BuildContext context) => Expanded(
                                      child: TextField(
                                    enabled: accountScreenStore.edit,
                                    controller: _controller2,
                                    textAlign: TextAlign.center,
                                  ))),
                          Container(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                          ),
                          Icon(Icons.account_box),
                          Container(
                            width: 20,
                          ),
                          Expanded(child: Text("City")),
                          Observer(
                              builder: (BuildContext context) => Expanded(
                                      child: TextField(
                                    enabled: accountScreenStore.edit,
                                    controller: _controller3,
                                    textAlign: TextAlign.center,
                                  ))),
                          Container(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
              ),
              Container(
                decoration: new BoxDecoration(
                    color: Colors.white, //n
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ], // ew Color.fromRGBO(255, 0, 0, 0.0),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(10.0))),
                height: MediaQuery.of(context).size.height * 1 / 9,
                width: MediaQuery.of(context).size.width * 6 / 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ListTile(
                        title: Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                        ),
                        Icon(Icons.account_box),
                        Container(
                          width: 20,
                        ),
                        Expanded(child: Text("Note")),
                        Observer(
                            builder: (BuildContext context) => Expanded(
                                    child: TextField(
                                  enabled: accountScreenStore.edit,
                                  controller: _controller4,
                                  textAlign: TextAlign.center,
                                ))),
                        Container(
                          width: 40,
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              Container(
                height: 40,
              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                children: <Widget>[
//                  RaisedButton(
//                    textColor: Color(AppColor.accentColor),
//                    color: Colors.white,
//                    child: Padding(
//                      padding: const EdgeInsets.all(20),
//                      child: Text(Constants.buttonCancel),
//                    ),
//                    onPressed: () {},
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(18.0),
//                        side: BorderSide(
//                            color: Color(AppColor.accentColor), width: 5)),
//                  ),
//                  RaisedButton(
//                    textColor: Colors.white,
//                    color: Color(AppColor.accentColor),
//                    child: Padding(
//                      padding: const EdgeInsets.all(20),
//                      child: Text(Constants.buttonSave),
//                    ),
//                    onPressed: () {},
//                    shape: RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(18.0),
//                        side: BorderSide(
//                            color: Color(AppColor.accentColor), width: 5)),
//                  ),
//                ],
//              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() {
    accountScreenStore.getAccount();
  }
}
