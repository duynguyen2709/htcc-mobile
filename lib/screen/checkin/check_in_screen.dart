import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/checkin/check_in_repository.dart';
import 'package:hethongchamcong_mobile/data/remote/checkin/model/check_in_info_response.dart';
import 'package:hethongchamcong_mobile/data/remote/checkin/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/screen/checkin/check_in_screen_store.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CheckInLocationPage extends StatefulWidget {
  CheckInLocationPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CheckInLocationPageState createState() => _CheckInLocationPageState();
}

class _CheckInLocationPageState extends State<CheckInLocationPage> {
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

  double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var theta = lon1 - lon2;
    var dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
    dist = acos(dist);
    dist = dist * 180.0 / pi;
    dist = dist * 60 * 1.1515;
    dist = dist * 1.609344;
    return dist;
  }

  double deg2rad(deg) {
    return deg * (pi / 180);
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

    _checkInStore = CheckInStore();
    _checkInStore.getCheckInInfo("VNG", "admin1", "20200317");
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
        });
      } else if (isSuccess != null)
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(_checkInStore.errorMsg),
        ));
    });

    reaction((_) => _checkInStore.checkInSuccess, (isSuccess) async {
      if (isSuccess == true) {
        _checkInStore.getCheckInInfo("VNG", "admin1", "20200317");
      } else if (isSuccess != null)
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(_checkInStore.errorMsg),
        ));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _getTime() {
    setState(() {
      now = TimeOfDay.fromDateTime(DateTime.now()).format(context);
      followingHours = now.indexOf("AM");
    });
  }

  var DayOfWeek = <int, String>{
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
    now = TimeOfDay.fromDateTime(DateTime.now()).format(context);
//    getLocation();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Stack(
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
                ? (checkInInfo.hasCheckedIn) ? _checkOutColor : _checkInColor
                : _checkInColor,
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 3.25),
          ),
          Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(now.replaceAll("AM", "").replaceAll("PM", ""),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 65,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                margin: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height / 8, 0, 0),
              ),
              Container(
                child: Text(
                    DayOfWeek[DateTime.now().weekday] +
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
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
              ),
              Center(
                child: _checkInButton(isInCompanyZone),
              ),
              (((!isInCompanyZone) ||
                          (checkInInfo != null && checkInInfo.hasCheckedIn)) &&
                      metersToCompanyZone != null)
                  ? Column(
                      children: <Widget>[
                        Container(
                          height: 30,
                        ),
                        Center(
                          child: Padding(
                            child: Text(
                                "Khoảng cách đến vị trí điểm danh hợp lệ : " +
                                    metersToCompanyZone.toStringAsFixed(0) +
                                    " m",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15)),
                            padding: EdgeInsets.fromLTRB(36, 0, 36, 0),
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
                            margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                          ),
                          Text(
                            "Đã điểm danh đầu ca - ${checkInInfo.checkinTime}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.only(bottom: 16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withAlpha(70), width: 1))),
                    )
                  : Container(),
              (checkInInfo != null && checkInInfo.hasCheckedOut)
                  ? Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xEEf3ba00)),
                          ),
                          Text(
                            "Đã điểm danh cuối ca - ${checkInInfo.checkoutTime}",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.only(bottom: 16),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withAlpha(70), width: 1))),
                    )
                  : Container(),
              Container(
                height: 50,
              )
            ],
          ),
        ],
      )),
    );
  }

  Widget _checkInButton(bool isCompanyZone) {
    return GestureDetector(
      onTap: () {
        CheckInParam param = new CheckInParam(
            username: "admin1",
            companyId: "VNG",
            clientTime: DateTime.now().millisecondsSinceEpoch,
            latitude: _curPosition.latitude,
            longitude: _curPosition.longitude,
            type: (checkInInfo.hasCheckedIn) ? 2 : 1,
            usedWifi: false);
        // ignore: unnecessary_statements
        if (!doneCheckIn && isInCompanyZone) _checkInStore.checkIn(param);
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
}
