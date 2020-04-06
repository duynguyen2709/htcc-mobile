import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_info.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/checkin/check_in_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CheckInLocationPage extends StatefulWidget {
  final MainScreenState parent;

  CheckInLocationPage({Key key, this.title, this.parent}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CheckInLocationPageState createState() => _CheckInLocationPageState(parent);
}

class _CheckInLocationPageState extends State<CheckInLocationPage> {
  final MainScreenState parent;
  Position _companyPosition;
  Position _curPosition = Position();
  bool isInCompanyZone = false;
  bool isOffDay = false;
  bool doneCheckIn = false;
  Timer _timer;
  String now;
  int followingHours;
  double metersToCompanyZone;
  Color _disableColor = Color(0xEEd0d0d0);
  Color _checkInColor = Colors.blue;
  Color _checkOutColor = Color(0xEEFF9A00);
  var _checkInGradient = [
    [Colors.blueAccent, Colors.lightBlue],
    [Colors.lightBlueAccent, Colors.blue],
  ];
  var _checkOutGradient = [
    [Color(0xeefda101), Color(0xeeff5a00)],
    [Color(0xeeefff00), Color(0xeeff9a00)],
  ];
  var _disableGradient = [
    [Color(0xEEd0d0d0), Color(0xEEd0d0d0)],
    [Color(0xEEd0d0d0), Color(0xEEd0d0d0)],
  ];

  CheckInStore _checkInStore;
  CheckInInfo checkInInfo;
  var _connectionStatus = 'Unknow';
  var wifiIP = '';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  _CheckInLocationPageState(this.parent);

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    _curPosition = await locateUser();
    if (_companyPosition != null) {
      var distance = await Geolocator().distanceBetween(
          _companyPosition.latitude,
          _companyPosition.longitude,
          _curPosition.latitude,
          _curPosition.longitude);
      if (this.mounted) {
        if (distance <= checkInInfo.maxAllowDistance) {
          if (mounted) {
            setState(() {
              isInCompanyZone = true;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              metersToCompanyZone = distance;
              isInCompanyZone = false;
            });
          }
        }
      } else {
        _timer.cancel();
      }
    }
  }

  Future<void> _refresh() async {
    var pref = await Pref.getInstance();
    User user = User.fromJson(json.decode(pref.getString(Constants.USER)));
    return await _checkInStore.getCheckInInfo(
        user.companyId, user.username, null);
  }

  openAlertBox(
      bool isCheckout, String timeValid, String timeNow, Function onContinue) {
    String content = "";
    if (isCheckout) {
      content = "Giờ tan ca hợp lệ là $timeValid. Bạn muốn tan ca sớm ?";
    } else {
      content =
          "Đã trễ giờ điểm danh. Giờ điểm danh hợp lệ là $timeValid. Bạn vẫn muốn điểm danh ?";
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0))),
            contentPadding: EdgeInsets.all(12.0),
            backgroundColor: Colors.white,
            content: Container(
              color: Colors.transparent,
              width: 300.0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Xác nhận",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        content,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Hủy",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            },
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 30,
                          width: 0.5,
                        ),
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tiếp tục",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              onContinue();
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            },
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    getUserLocation();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getUserLocation();
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      _getTime();
    });

    connectivity = Connectivity();
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
      if(result == ConnectivityResult.wifi){
         wifiIP = await (Connectivity().getWifiIP());
         _connectionStatus="wifi";
      }
      else if(result == ConnectivityResult.mobile){
        _connectionStatus="mobile";
      }
    });
    _checkInStore = CheckInStore();
    Pref.getInstance().then((pref) {
      User user = User.fromJson(json.decode(pref.getString(Constants.USER)));
      _checkInStore.getCheckInInfo(user.companyId, user.username, null);
    });
    reaction((_) => _checkInStore.getInfoCheckInSuccess, (isSuccess) async {
      if (isSuccess == true) {
        var sharedPreference = await SharedPreferences.getInstance();
        var checkInInfoJson =
            sharedPreference.getString(Constants.CHECK_IN_INFO);
        checkInInfo = CheckInInfo.fromJson(json.decode(checkInInfoJson));
        _companyPosition = Position(
            longitude: checkInInfo.validLongitude,
            latitude: checkInInfo.validLatitude);
        setState(() {
          if (!checkInInfo.canCheckin) isOffDay = true;
          if (checkInInfo.hasCheckedIn && checkInInfo.hasCheckedOut)
            doneCheckIn = true;
          else
            doneCheckIn = false;
        });
      } else if (isSuccess != null)
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(_checkInStore.errorMsg),
        ));
    });

    reaction((_) => _checkInStore.checkInSuccess, (isSuccess) async {
      if (isSuccess == true) {
        Pref.getInstance().then((pref) {
          User user =
              User.fromJson(json.decode(pref.getString(Constants.USER)));
          _checkInStore.getCheckInInfo(user.companyId, user.username, null);
        });
      } else if (isSuccess != null)
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(_checkInStore.errorMsg),
        ));
    });

    reaction((_) => _checkInStore.errorAuth, (errorAuthenticate) async {
      if (errorAuthenticate) {
        _showErrorDialog(true);
      }
    });
  }

  void _showErrorDialog(bool isAuthErr) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Constants.titleErrorDialog),
          content: new Text(_checkInStore.errorMsg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(Constants.buttonErrorDialog),
              onPressed: () {
                Navigator.of(context).pop();
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

  @override
  void dispose() {
    _timer.cancel();
    subscription.cancel();
    super.dispose();
  }

  void _getTime() {
    if (mounted)
      setState(() {
        var time = TimeOfDay.fromDateTime(DateTime.now());
        if (time.hour >= 12)
          followingHours = 2;
        else {
          followingHours = 1;
        }
        if(time.hour>12){
          time = time.replacing(hour: time.hourOfPeriod);
        }
        now = (time.hour > 9 ? "${time.hour}:" : "0${time.hour}:") +
            (time.minute > 9 ? "${time.minute}" : "0${time.minute}");
      });
  }

  var dayOfWeek = <int, String>{
    1: "Thứ Hai",
    2: "Thứ Ba",
    3: "Thứ Tư",
    4: "Thứ Năm",
    5: "Thứ Sáu",
    6: "Thứ Bảy",
    7: "Chủ Nhật"
  };

  @override
  Widget build(BuildContext context) {
    _getTime();
    if (checkInInfo != null) {
      if (parent.getSelectedIndex() == 0)
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: checkInInfo.hasCheckedIn
              ? _checkOutColor
              : _checkInColor, //or set color with: Color(0xFF0000FF)
        ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.blue, // status bar color
      ));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                WaveWidget(
                  config: CustomConfig(
                    gradients: (checkInInfo != null)
                        ? (checkInInfo.hasCheckedIn)
                            ? _checkOutGradient
                            : _checkInGradient
                        : _checkInGradient,
                    durations: [8000, 5000],
                    heightPercentages: [0.4, 0.42],
                    gradientBegin: Alignment.topLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 10,
                  backgroundColor: (checkInInfo != null)
                      ? (checkInInfo.hasCheckedIn)
                          ? _checkOutColor
                          : _checkInColor
                      : _checkInColor,
                  size: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height / 3.125),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(now,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold)),
                          Text(followingHours == 1 ? " AM" : " PM",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height / 8, 0, 0),
                    ),
                    Container(
                      child: Text(
                          dayOfWeek[DateTime.now().weekday] +
                              ", " +
                              DateTime.now().day.toString() +
                              "/" +
                              DateTime.now().month.toString() +
                              "/" +
                              DateTime.now().year.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500)),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                    ),
                    (checkInInfo != null && checkInInfo.canCheckin)
                        ? Column(
                            children: <Widget>[
                              Center(
                                child: _checkInButton(isInCompanyZone),
                              ),
                              (((!isInCompanyZone)) &&
                                      metersToCompanyZone != null &&
                                      !doneCheckIn)
                                  ? Column(
                                      children: <Widget>[
                                        Container(
                                          height: 30,
                                        ),
                                        Center(
                                          child: Padding(
                                            child: Text(
                                                "Khoảng cách đến vị trí điểm danh hợp lệ : " +
                                                    metersToCompanyZone
                                                        .toStringAsFixed(0) +
                                                    " m",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 15)),
                                            padding: EdgeInsets.fromLTRB(
                                                36, 0, 36, 0),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(
                                      height: 0,
                                    ),
                              Container(height: 40),
                              (checkInInfo != null && checkInInfo.hasCheckedIn)
                                  ? Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10,
                                            width: 10,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 16, 0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue),
                                          ),
                                          Text(
                                            "Đã điểm danh đầu ca - ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: isCheckInLate()
                                                      ? Colors.red
                                                      : Colors.blue),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                            child: Text(
                                              checkInInfo.checkinTime,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                      margin: EdgeInsets.all(16),
                                      padding: EdgeInsets.only(bottom: 16),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.withAlpha(70),
                                                  width: 1))),
                                    )
                                  : Container(),
                              (checkInInfo != null && checkInInfo.hasCheckedOut)
                                  ? Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10,
                                            width: 10,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 16, 0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xEEf3ba00)),
                                          ),
                                          Text(
                                            "Đã điểm danh cuối ca - ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: isCheckOutEarly()
                                                      ? Colors.red
                                                      : _checkOutColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                            child: Text(
                                              checkInInfo.checkoutTime,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                      margin: EdgeInsets.all(16),
                                      padding: EdgeInsets.only(bottom: 16),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.withAlpha(70),
                                                  width: 1))),
                                    )
                                  : Container(),
                              Container(
                                height: 50,
                              )
                            ],
                          )
                        : _dayOffPage,
                  ],
                ),
                Observer(builder: (_) {
                  if (_checkInStore.isLoading)
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
          ],
        ),
      ),
    );
  }

  Widget get _dayOffPage {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        (checkInInfo != null && checkInInfo.hasCheckedIn)
            ? Image.asset("assets/empty_icon_check_out.PNG")
            : Image.asset("assets/empty_icon.PNG"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hôm nay là ngày nghỉ.\nBạn không cần phải điểm danh",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _checkInButton(bool isCompanyZone) {
    return GestureDetector(
      onTap: (doneCheckIn || !isInCompanyZone || isOffDay)
          ? null
          : () async {
              var sharedPreference = await SharedPreferences.getInstance();
              CheckInInfo info = CheckInInfo.fromJson(json
                  .decode(sharedPreference.getString(Constants.CHECK_IN_INFO)));
              User user = User.fromJson(
                  json.decode(sharedPreference.getString(Constants.USER)));
              CheckInParam param = new CheckInParam(
                  username: user.username,
                  companyId: user.companyId,
                  clientTime: DateTime
                      .now()
                      .millisecondsSinceEpoch,
                  latitude: _curPosition.latitude,
                  longitude: _curPosition.longitude,
                  type: (info.hasCheckedIn) ? 2 : 1,
                  usedWifi: _connectionStatus.compareTo("wifi") == 0
                      ? true
                      : false,
                  ip: _connectionStatus.compareTo("wifi") == 0 ? wifiIP : '');
              TimeOfDay _startTime;
              if (!info.hasCheckedIn) {
                _startTime = TimeOfDay(
                    hour: int.parse(info.validCheckinTime.split(":")[0]),
                    minute: int.parse(info.validCheckinTime.split(":")[1]));
              } else {
                _startTime = TimeOfDay(
                    hour: int.parse(info.validCheckoutTime.split(":")[0]),
                    minute: int.parse(info.validCheckoutTime.split(":")[1]));
              }
              TimeOfDay _currentTime = TimeOfDay.fromDateTime(DateTime.now());
              if (!info.hasCheckedIn) {
                if ((_currentTime.hour > _startTime.hour) ||
                    (_currentTime.hour == _startTime.hour &&
                        _currentTime.minute > _startTime.minute)) {
                  openAlertBox(false, info.validCheckinTime,
                      _currentTime.format(context), () async {
                    _checkInStore.checkIn(param);
                  });
                } else if (!doneCheckIn && isInCompanyZone)
                  _checkInStore.checkIn(param);
              } else {
                if ((_currentTime.hour < _startTime.hour) ||
                    (_currentTime.hour == _startTime.hour &&
                        _currentTime.minute < _startTime.minute)) {
                  openAlertBox(true, info.validCheckoutTime,
                      _currentTime.format(context), () async {
                    _checkInStore.checkIn(param);
                  });
                } else if (!doneCheckIn && isInCompanyZone)
                  _checkInStore.checkIn(param);
              }
            },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: (isCompanyZone && !doneCheckIn && !isOffDay)
                    ? (checkInInfo != null)
                        ? (checkInInfo.hasCheckedIn)
                            ? _checkOutColor
                            : _checkInColor
                        : _checkInColor
                    : _disableColor,
                width: 2)),
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              ClipOval(
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: (isCompanyZone && !doneCheckIn && !isOffDay)
                        ? (checkInInfo != null)
                            ? (checkInInfo.hasCheckedIn)
                                ? _checkOutGradient
                                : _checkInGradient
                            : _checkInGradient
                        : _disableGradient,
                    durations: [20000, 19440],
                    heightPercentages: [0.4, 0.45],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  backgroundColor: (isCompanyZone && !doneCheckIn && !isOffDay)
                      ? (checkInInfo != null)
                          ? (checkInInfo.hasCheckedIn)
                              ? _checkOutColor
                              : _checkInColor
                          : _checkInColor
                      : _disableColor,
                  size: Size(MediaQuery.of(context).size.width / 2.25,
                      MediaQuery.of(context).size.width / 2.25),
                ),
              ),
              Text("Điểm danh",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ],
          ),
        ),
      ),
    );
  }

  bool isCheckInLate() {
    TimeOfDay _startTime = TimeOfDay(
        hour: int.parse(checkInInfo.validCheckinTime.split(":")[0]),
        minute: int.parse(checkInInfo.validCheckinTime.split(":")[1]));
    TimeOfDay _currentTime = TimeOfDay.fromDateTime(DateTime.now());
    if ((_currentTime.hour > _startTime.hour) ||
        (_currentTime.hour == _startTime.hour &&
            _currentTime.minute > _startTime.minute))
      return true;
    else
      return false;
  }

  isCheckOutEarly() {
    TimeOfDay _startTime = TimeOfDay(
        hour: int.parse(checkInInfo.validCheckoutTime.split(":")[0]),
        minute: int.parse(checkInInfo.validCheckoutTime.split(":")[1]));
    TimeOfDay _currentTime = TimeOfDay.fromDateTime(DateTime.now());
    if ((_currentTime.hour < _startTime.hour) ||
        (_currentTime.hour == _startTime.hour &&
            _currentTime.minute < _startTime.minute))
      return true;
    else
      return false;
  }
}
