import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_info.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import './check_in_screen_store.dart';

class CheckInForm extends StatefulWidget {
  final CheckInStore store;

  const CheckInForm({Key key, this.store}) : super(key: key);

  @override
  _CheckInFormState createState() => _CheckInFormState(store);
}

class _CheckInFormState extends State<CheckInForm> {
  final CheckInStore store;
  OfficeDetail curOffice;
  List<OfficeDetail> offices;
  List<String> typeCheckIn = ["Điểm danh vào ca", "Điểm danh tan ca"];
  String curType = "Điểm danh vào ca";
  String _time = DateFormat('HH:mm').format(DateTime.now());
  String _date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  TextEditingController _controller;
  var _opacity = 1.0;
  var _alignment = Alignment.center;
  var _isBack = false;
  var _timer;
  var _connectionStatus = 'Unknow';
  var wifiIP = '';
  User userInfo;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  _CheckInFormState(this.store);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    curOffice = store.checkInInfo.officeList[0];
    offices = store.checkInInfo.officeList;
    curOffice = store.checkInInfo.officeList[0];
    Pref.getInstance().then((pref) {
      userInfo = User.fromJson(json.decode(pref.getString(Constants.USER)));
    });
    //catch connectivity change
    connectivity = Connectivity();
    subscription = connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.wifi) {
        wifiIP = await (Connectivity().getWifiIP());
        _connectionStatus = "wifi";
      } else if (result == ConnectivityResult.mobile) {
        _connectionStatus = "mobile";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Form Điểm Danh"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(24, 8, 24, 12),
            color: Colors.blue,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(26, 28, 0, 0),
                        child: Text(
                          "Chi nhánh",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(24, 4, 24, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: FormField<OfficeDetail>(
                        builder: (FormFieldState<OfficeDetail> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              fillColor: Colors.white,
                            ),
                            isEmpty: curOffice.officeId == '' ||
                                curOffice == null ||
                                curOffice.officeId == null,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<OfficeDetail>(
                                value: curOffice,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    curOffice = newValue;
                                  });
                                },
                                items: offices != null
                                    ? offices.map((OfficeDetail value) {
                                        return DropdownMenuItem<OfficeDetail>(
                                          value: value,
                                          child: Text(value.officeId),
                                        );
                                      }).toList()
                                    : List(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(26, 8, 0, 0),
                        child: Text(
                          "Loại điểm danh",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(24, 4, 24, 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              fillColor: Colors.white,
                            ),
                            isEmpty: curType == '' || curType == null,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: curType,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    curType = newValue;
                                  });
                                },
                                items: typeCheckIn.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(26, 8, 0, 0),
                        child: Text(
                          "Ngày điểm danh",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(24, 8, 24, 8),
                        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          " $_date",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.calendar_today,
                                  size: 24,
                                  color: Colors.lightBlue,
                                ),
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      onChanged: (date) {}, onConfirm: (date) {
                                    _date =
                                        DateFormat('dd/MM/yyyy').format(date);
                                    setState(() {});
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.vi,
                                      maxTime: DateTime.now(),
                                      minTime: DateTime.now()
                                          .subtract(Duration(days: 31)));
                                },
                              ),
                            ],
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(26, 4, 0, 0),
                        child: Text(
                          "Giờ điểm danh",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(24, 4, 24, 4),
                        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          " $_time",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.access_time,
                                  size: 28,
                                  color: Colors.lightBlue,
                                ),
                                onPressed: () {
                                  DatePicker.showTimePicker(context,
                                      theme: DatePickerTheme(
                                        containerHeight: 210.0,
                                      ),
                                      showTitleActions: true,
                                      onConfirm: (time) {
                                    print('confirm $time');
                                    var formatter = new DateFormat('HH:mm');
                                    _time = formatter.format(time);
                                    setState(() {});
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(26, 8, 0, 0),
                        child: Text(
                          "Lý do",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(24, 8, 24, 16),
                        child: TextField(
                          minLines: 8,
                          maxLines: 50,
                          textAlign: TextAlign.left,
                          controller: _controller,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Color(0xff00b0e3))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(color: Colors.grey)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          AnimatedContainer(
                            duration: Duration(seconds: _isBack ? 0 : 4),
                            alignment: _alignment,
                            child: AnimatedOpacity(
                              opacity: _opacity,
                              duration: Duration(seconds: _isBack ? 0 : 3),
                              child: Icon(
                                Icons.send,
                                color: Colors.blue,
                                size: 35,
                              ),
                            ),
                          ),
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            padding: EdgeInsets.only(left: 6),
                            alignment: Alignment.center,
                            child: InkWell(
                              splashColor: Colors.grey,
                              onTap: () async {
                                if (_controller.text.isNotEmpty &&
                                    _time != "Chưa thiết lập") {
                                  store.checkInForm(getCheckInParam());
                                  if (_timer != null) _timer.cancel();
                                  _timer =
                                      new Timer(const Duration(seconds: 5), () {
                                    if (mounted) {
                                      setState(() {
                                        _isBack = true;
                                        _alignment = Alignment.center;
                                        _opacity = 1.0;
                                      });
                                    }
                                  });
                                  if (mounted)
                                    setState(() {
                                      _isBack = false;
                                      _alignment =
                                          _alignment == Alignment.bottomRight
                                              ? Alignment.center
                                              : Alignment.bottomRight;
                                      _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                                    });
                                } else {
                                  if (_controller.text.isEmpty)
                                    _showMessage("Vui lòng nhập lý do.");
                                  else
                                    _showMessage(
                                        "Vui lòng chọn thời gian điểm danh.");
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Observer(builder: (_) {
            if (store.isLoading == true)
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
    );
  }

  CheckInParam getCheckInParam() {
    var dateTimeCheckIn = DateFormat("dd/MM/yyyy").parse(_date);
    var time = DateFormat("HH:mm").parse(_time);
    dateTimeCheckIn.add(Duration(hours: time.hour, minutes: time.minute));
    return new CheckInParam(
      username: userInfo.username,
      companyId: userInfo.companyId,
      clientTime: dateTimeCheckIn.millisecondsSinceEpoch +
          time.hour * 60 * 60 * 1000 +
          time.minute * 60 * 1000,
      latitude: 0,
      longitude: 0,
      officeId: curOffice.officeId,
      type: (curType == "Điểm danh vào ca") ? 1 : 2,
      usedWifi: _connectionStatus.compareTo("wifi") == 0 ? true : false,
      ip: _connectionStatus.compareTo("wifi") == 0 ? wifiIP : '',
      reason: _controller.text,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    subscription.cancel();
    super.dispose();
  }

  void _showErrorDialog(bool isAuthErr) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Constants.titleErrorDialog),
          content:
              new Text(store.checkInSuccess ? store.message : store.errorMsg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(Constants.buttonErrorDialog),
              onPressed: () {
                Navigator.of(context).pop();
                if (store.checkInSuccess == true)
                  Navigator.pop(context, "success");
                if (isAuthErr)
                  Navigator.pushReplacementNamed(
                      context, Constants.login_screen);
              },
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Constants.titleErrorDialog),
          content: new Text(msg),
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
}
