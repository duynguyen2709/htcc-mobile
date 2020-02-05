import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hethongchamcong_mobile/constant.dart';
import 'package:hethongchamcong_mobile/model/account.dart';
import 'package:hethongchamcong_mobile/repository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shimmer/shimmer.dart';

class AccountScreen extends StatefulWidget {
  final AccountRepository _accountRepository = AccountRepository();

  @override
  State<StatefulWidget> createState() {
    return _AccountScreenState();
  }
}

class _AccountScreenState extends State<AccountScreen> {
  AccountModel _accountModel;

  @override
  void initState() {
    super.initState();
    _accountModel = AccountModel(widget._accountRepository);
    _accountModel.getAccount();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _accountModel,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
//                  child: Image(
//                    fit: BoxFit.fill,
//                    image: AssetImage('assets/login_header.jpg')
//                  ),
                )
              ],
            ),
            ScopedModelDescendant<AccountModel>(
              builder: (context, child, model) {
                if (model.isLoading) {
                  return _buildLoading(model.account);
                } else {
                  return _buildUnLoading(model.account);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(Account account) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppBar(
                  leading: IconButton(
                    icon: new Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: Colors.blue,
                  title: Text(Constants.titleAppBarAccountScreen),
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.more, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      textColor: Color(0xff00b0e3),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(Constants.buttonCancel),
                      ),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xff00b0e3), width: 5)),
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xff00b0e3),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(Constants.buttonSave),
                      ),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xff00b0e3), width: 5)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnLoading(Account account) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppBar(
                  leading: IconButton(
                    icon: new Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: Colors.blue,
                  title: Text(Constants.titleAppBarAccountScreen),
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.more, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: 90,
                  height: 90,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/login_header.jpg',
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
                          Text(account.gender),
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
                            Text(account.age),
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
                            Text(account.city),
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
                          Text(account.gender),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      textColor: Color(0xff00b0e3),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(Constants.buttonCancel),
                      ),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xff00b0e3), width: 5)),
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xff00b0e3),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(Constants.buttonSave),
                      ),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xff00b0e3), width: 5)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
