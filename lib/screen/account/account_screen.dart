import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/account/account_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/empty_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/retry_screen.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountScreenState();
  }
}

class _AccountScreenState extends State<AccountScreen> {
  AccountScreenStore accountScreenStore;

  TextEditingController _controllerId;

  TextEditingController _controllerFullName;

  TextEditingController _controllerBirthDay;

  TextEditingController _controllerPhone;

  TextEditingController _controllerOfficeId;

  TextEditingController _controllerDepartment;

  TextEditingController _controllerEmail;

  TextEditingController _controllerAddress;

  @override
  void initState() {
    super.initState();
    accountScreenStore = AccountScreenStore();

    _controllerId = TextEditingController();

    _controllerFullName = TextEditingController();

    _controllerBirthDay = TextEditingController();

    _controllerPhone = TextEditingController();

    _controllerOfficeId = TextEditingController();

    _controllerDepartment = TextEditingController();

    _controllerEmail = TextEditingController();

    _controllerAddress = TextEditingController();

    accountScreenStore.getAccount();

    reaction((_) => accountScreenStore.errorUpdate, (bool error) {
      if (error == null) return;
      if (error) {
        _showErrorDialog();
        accountScreenStore.errorUpdate = null;
      } else {
        _showErrorDialog();
        accountScreenStore.errorUpdate = null;
      }
    });

    reaction((_) => accountScreenStore.errorAuthenticate, (bool errorAuthenticate) {
      if (errorAuthenticate) {
        _showErrorDialog();
        Navigator.pushReplacementNamed(context, Constants.login_screen);
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
          content: new Text(accountScreenStore.message),
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
        appBar: AppBar(
          title: Text("Thông tin cá nhân"),
          centerTitle: true,
          actions: <Widget>[
            Observer(
              builder: (BuildContext context) {
                if (accountScreenStore.isConfig)
                  return IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      accountScreenStore.updateAccount();
                    },
                  );
                else
                  return Center();
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Observer(
              builder: (_) {
                if (accountScreenStore.errorNetwork)
                  return RetryScreen(
                    refresh: _refresh,
                  );
                if (accountScreenStore.account == null)
                  return EmptyScreen(
                    refresh: _refresh,
                  );
                else
                  return buildSuccess(accountScreenStore.account);
              },
            ),
            Observer(
              builder: (_) {
                if (accountScreenStore.isLoading)
                  return LoadingScreen();
                else
                  return Center();
              },
            )
          ],
        ));
  }

  Widget buildSuccess(User account) {
    _controllerId.text = account.employeeId;

    _controllerFullName.text = account.fullName;

    _controllerBirthDay.text = account.birthDate;

    _controllerPhone.text = account.phoneNumber;

    _controllerOfficeId.text = account.officeId;

    _controllerDepartment.text = account.department;

    _controllerEmail.text = account.email;

    _controllerAddress.text = account.address;

    return RefreshIndicator(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueAccent, Colors.blue, Colors.lightBlue, Colors.lightBlueAccent]),
        ),
        padding: const EdgeInsets.only(top: 8, bottom: 15, left: 8, right: 8),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
              width: 90,
              height: 90,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/gif/loading.gif',
                    image: account.avatar,
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          color: Colors.white),
                      controller: _controllerId,
                      labelText: "Mã số nhân viên",
                      textStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      controller: _controllerFullName,
                      labelText: "Họ và tên",
                      textStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.fullName = text;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      controller: _controllerBirthDay,
                      labelText: "Ngày sinh",
                      textStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.birthDate = text;
                      },
                      isDate: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      controller: _controllerPhone,
                      labelText: "Số điện thoại",
                      textStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.phoneNumber = text;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      controller: _controllerEmail,
                      labelText: "Email",
                      textStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.email = text;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      controller: _controllerAddress,
                      labelText: "Địa chỉ",
                      textStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.address = text;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      boxDecoration: BoxDecoration(color: Colors.white),
                      controller: _controllerOfficeId,
                      labelText: "Mã trụ sở",
                      textStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      boxDecoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          color: Colors.white),
                      controller: _controllerDepartment,
                      labelText: "Trụ sở",
                      textStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ), onRefresh: _refresh,
    );
  }

  Future<void> _refresh() async {
    accountScreenStore.refresh();
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key key,
      @required this.controller,
      @required this.labelText,
      @required this.textStyle,
      @required this.boxDecoration})
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextStyle textStyle;
  final BoxDecoration boxDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          enabled: false,
          style: textStyle,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 5),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black45, fontSize: 17),
              disabledBorder: InputBorder.none),
        ),
      ),
    );
  }
}

class CustomSuffixTextField extends StatelessWidget {
  const CustomSuffixTextField(
      {Key key,
      @required this.controller,
      @required this.labelText,
      @required this.textStyle,
      this.isDate = false,
      this.callbackUpdateStore})
      : super(key: key);

  final TextEditingController controller;

  final String labelText;

  final TextStyle textStyle;

  final bool isDate;

  final Function callbackUpdateStore;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.black26))),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    enabled: false,
                    style: textStyle,
                    controller: controller,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5),
                        labelText: labelText,
                        labelStyle: TextStyle(color: Colors.black45, fontSize: 17),
                        disabledBorder: InputBorder.none),
                  ),
                ),
                isDate
                    ? IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.date_range),
                        onPressed: () {
                          DatePicker.showDatePicker(context, showTitleActions: true, onChanged: (date) {},
                              onConfirm: (date) {
                            controller.text = DateFormat('yyyy-MM-dd').format(date);
                            callbackUpdateStore(controller.text);
                          }, currentTime: DateTime.now(), locale: LocaleType.vi);
                        })
                    : IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          TextEditingController textController = TextEditingController(text: controller.text);
                          showDialog(
                              context: context,
                              child: Dialog(
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 3,
                                  child: Scaffold(
                                    appBar: AppBar(
                                      automaticallyImplyLeading: false,
                                      title: Text("Chỉnh sửa"),
                                      centerTitle: true,
                                    ),
                                    body: Container(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextField(
                                                style: textStyle,
                                                controller: textController,
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.only(top: 5),
                                                    labelText: labelText,
                                                    labelStyle: TextStyle(color: Colors.black45, fontSize: 15),
                                                    disabledBorder: InputBorder.none),
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: RaisedButton(
                                                      child: Text("Hủy bỏ"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: RaisedButton(
                                                      child: Text("Đồng ý"),
                                                      onPressed: () {
                                                        callbackUpdateStore(textController.text);
                                                        controller.text = textController.text;
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        },
                      )
              ],
            ),
          ),
        ));
  }
}
