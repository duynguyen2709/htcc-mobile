import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_info.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/data/model/qr_code_data.dart';
import 'package:hethongchamcong_mobile/data/model/screen.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/checkin/check_in_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/dialog/app_dialog.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:hethongchamcong_mobile/utils/MeasureSize.dart';
import 'package:mobx/mobx.dart';
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
  User userInfo;
  Position _companyPosition;
  Position _curPosition = Position();
  bool isInCompanyZone = false;
  bool isOffDay = false;
  Timer _timer;
  String now;
  int followingHours;
  double metersToCompanyZone;
  Color _disableColor = Color(0xEEd0d0d0);
  Color _checkInColor = Colors.blue;
  Color _checkOutColor = Color(0xEEFF9A00);
  Color _color = Color(0xEEd0d0d0);
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
  var _colorGradient = [
    [Color(0xEEd0d0d0), Color(0xEEd0d0d0)],
    [Color(0xEEd0d0d0), Color(0xEEd0d0d0)],
  ];

  var dayOfWeek = <int, String>{
    1: "Thứ Hai",
    2: "Thứ Ba",
    3: "Thứ Tư",
    4: "Thứ Năm",
    5: "Thứ Sáu",
    6: "Thứ Bảy",
    7: "Chủ Nhật"
  };

  CheckInStore _checkInStore;
  OfficeDetail curOffice;
  List<DetailCheckInTime> detailCheckInTimes;
  var _connectionStatus = 'Unknow';
  var wifiIP = '';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  _CheckInLocationPageState(this.parent);

  var width = 60.0;
  var isExpanded = false;
  double expandWidth = 222;

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    //init store
    _checkInStore = CheckInStore();
    //get check in info
    Pref.getInstance().then((pref) {
      userInfo = User.fromJson(json.decode(pref.getString(Constants.USER)));
      _checkInStore.getCheckInInfo(userInfo.companyId, userInfo.username, null);
    });
    getUserLocation();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getUserLocation();
    });
    //set timer to change current time
    Timer.periodic(Duration(seconds: 1), (timer) {
      _getTime();
    });

    //catch connectivity change
    connectivity = Connectivity();
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.wifi) {
        wifiIP = await (Connectivity().getWifiIP());
        _connectionStatus = "wifi";
      } else if (result == ConnectivityResult.mobile) {
        _connectionStatus = "mobile";
      }
    });

    //observe change from store
    reaction((_) => _checkInStore.currentCheckInOffice, (office) {
      if (office != null && curOffice == null) {
        curOffice = office;
        _companyPosition = Position(longitude: office.validLongitude, latitude: office.validLatitude);
        setState(() {
          if (!office.canCheckIn) isOffDay = true;
        });
      } else {
        curOffice = _checkInStore.checkInInfo.officeList.firstWhere((office) => office.officeId == curOffice.officeId);
      }
    });
    reaction((_) => _checkInStore.getInfoCheckInSuccess, (isSuccess) async {
      if (isSuccess == true) {
        detailCheckInTimes = _checkInStore.checkInInfo.detailCheckIn;
      } else if (isSuccess != null) if (_checkInStore.errorAuth == true)
        AppDialog.showDialogNotify(context, _checkInStore.errorMsg, () {
          Navigator.pushReplacementNamed(context, Constants.login_screen);
        });
      else
        AppDialog.showDialogNotify(context, _checkInStore.errorMsg, () {});
    });

     reaction((_) => _checkInStore.checkInSuccess, (isSuccess) async {
      if (isSuccess == true) {
        _checkInStore.getCheckInInfo(userInfo.companyId, userInfo.username, null);
        AppDialog.showDialogNotify(context, "Điểm danh thành công", (){
          _checkInStore.getCheckInInfo(
              userInfo.companyId, userInfo.username, null);
            while(Navigator.of(context).canPop()){
              Navigator.of(context).pop();
            }
        });
      } else if (isSuccess != null) if (_checkInStore.errorAuth == true)
        AppDialog.showDialogNotify(context, _checkInStore.errorMsg, () {
          Navigator.pushReplacementNamed(context, Constants.login_screen);
        });
      else
        AppDialog.showDialogNotify(context, _checkInStore.errorMsg, () { });
    });

    reaction((_) => _checkInStore.errorAuth, (errorAuthenticate) async {
      if (errorAuthenticate == true) {
        AppDialog.showDialogNotify(context, _checkInStore.errorMsg, () {
          Navigator.pushReplacementNamed(context, Constants.login_screen);
        });
      }
    });
  }

  Future<Position> locateUser() async {
    return Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  double checkWidthCheckinBar() {
    double tmp = 222;
    int index = 0;
    if (!checkScreen(Constants.CHECKIN_QR)) index++;
    if (!checkScreen(Constants.CHECKIN_IMAGE)) index++;
    if (!checkScreen(Constants.CHECKIN_FORM)) index++;
    tmp = tmp - 222 * index / 3;
    if (tmp < 150) {
      tmp = 150;
    }
    return tmp;
  }
  getUserLocation() async {
    _curPosition = await locateUser();
    if (_companyPosition != null) {
      var distance = await Geolocator().distanceBetween(
          _companyPosition.latitude, _companyPosition.longitude, _curPosition.latitude, _curPosition.longitude);
      _checkInStore.setLoading(false);
      if (mounted) {
        if (distance <= (curOffice != null ? curOffice.maxAllowDistance : 0)) {
          setState(() {
            isInCompanyZone = true;
          });
        } else {
          setState(() {
            metersToCompanyZone = distance;
            isInCompanyZone = false;
          });
        }
      } else {
        _timer.cancel();
      }
    }
  }

  Future<void> _refresh() async {
    return await _checkInStore.getCheckInInfo(userInfo.companyId, userInfo.username, null);
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
        if (time.hour > 12) {
          time = time.replacing(hour: time.hourOfPeriod);
          _color = _checkOutColor;
          _colorGradient = _checkOutGradient;
        } else {
          _color = _checkInColor;
          _colorGradient = _checkInGradient;
        }
        now = (time.hour > 9 ? "${time.hour}:" : "0${time.hour}:") +
            (time.minute > 9 ? "${time.minute}" : "0${time.minute}");
      });
  }

  var heightScreen = Size.zero;

  @override
  Widget build(BuildContext context) {
    _getTime();
    if (parent.getSelectedIndex() == 0)
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: _color));

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Stack(
              children: <Widget>[
                WaveWidget(
                  config: CustomConfig(
                    gradients: _colorGradient,
                    durations: [8000, 5000],
                    heightPercentages: [0.25, 0.3],
                    gradientBegin: Alignment.topLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 10,
                  backgroundColor: _color,
                  size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height / 2),
                ),
                Positioned(
                    top: 0,
                    right: -16,
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        width: this.width,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xEEFFFFFF).withOpacity(0.35),
                                borderRadius: BorderRadius.all(Radius.circular(24))),
                            child: !isExpanded
                                ? IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        expandWidth = checkWidthCheckinBar();
                                        isExpanded = !isExpanded;
                                        width = width == 60 ? expandWidth : 60.0;
                                      });
                                    },
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            expandWidth = checkWidthCheckinBar();
                                            isExpanded = !isExpanded;
                                            width = width == 60 ? expandWidth : 60;
                                          });
                                        },
                                      ),
                                      (checkScreen(Constants.CHECKIN_IMAGE))
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              ),
                                              onPressed: () async {
                                                var res = await Navigator.pushNamed(
                                                    context, Constants.check_in_camera_screen,
                                                    arguments: _checkInStore);
                                                if (res != null)
                                                  _checkInStore.getCheckInInfo(
                                                      userInfo.companyId, userInfo.username, null);
                                              },
                                            )
                                          : Center(),
                                      (checkScreen(Constants.CHECKIN_QR))
                                          ? GestureDetector(
                                              onTap: () => scanQR(),
                                              child: Image.asset('assets/qr-scan-icon.png', width: 28, height: 30),
                                            )
                                          : Center(),
                                      (checkScreen(Constants.CHECKIN_FORM))
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.note_add,
                                                color: Colors.white,
                                              ),
                                              onPressed: () => Navigator.pushNamed(context, Constants.check_in_form,
                                                  arguments: _checkInStore))
                                          : Center(),
                                      Container(width: 16),
                                    ],
                                  )))),
                MeasureSize(
                  onChange: (size) {
                    heightScreen = size;
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(now, style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold)),
                            Text(followingHours == 1 ? " AM" : " PM",
                                style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        margin: EdgeInsets.fromLTRB(0, 56, 0, 0),
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
                            style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500)),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                      Container(
                        height: 8,
                      ),
                      curOffice != null
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                              margin: EdgeInsets.symmetric(horizontal: 56, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: FormField<OfficeDetail>(
                                builder: (FormFieldState<OfficeDetail> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: "Chi nhánh",
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                      fillColor: Colors.white,
                                    ),
                                    isEmpty:
                                        curOffice.officeId == '' || curOffice == null || curOffice.officeId == null,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<OfficeDetail>(
                                        value: curOffice,
                                        isDense: true,
                                        onChanged: (newValue) {
                                          setState(() {
                                            curOffice = newValue;
                                          });
                                          getUserLocation();
                                          _checkInStore.setLoading(true);
                                        },
                                        items: _checkInStore.checkInInfo.officeList.map((OfficeDetail value) {
                                          return DropdownMenuItem<OfficeDetail>(
                                            value: value,
                                            child: Text(value.officeId),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                        padding: EdgeInsets.only(top: 48),
                        child: (curOffice != null && curOffice.canCheckIn)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _checkInButton(isInCompanyZone),
                                  ((!isInCompanyZone) && metersToCompanyZone != null)
                                      ? Container(
                                          margin: EdgeInsets.only(top: 30),
                                          child: Center(
                                            child: Padding(
                                              child: Text(
                                                  "Khoảng cách đến vị trí điểm danh hợp lệ : " +
                                                      metersToCompanyZone.toStringAsFixed(0) +
                                                      " m",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 15)),
                                              padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 0,
                                        ),
                                  Container(height: 40),
                                  detailCheckInTimes.length > 0
                                      ? ConstrainedBox(
                                          constraints: BoxConstraints(minHeight: 200),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context, int index) {
                                              return new Stack(
                                                children: <Widget>[
                                                  new Padding(
                                                    padding: const EdgeInsets.only(left: 48.0),
                                                    child: new Card(
                                                      margin: new EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                                      child: new Container(
                                                        padding: EdgeInsets.all(16),
                                                        width: double.infinity,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Text(
                                                              "Đã điểm danh ${detailCheckInTimes[index].type == 1 ? "vào ca" : "tan ca"} lúc - ",
                                                              textAlign: TextAlign.start,
                                                              style: TextStyle(fontSize: 17),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.all(4),
                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: !detailCheckInTimes[index].isOnTime
                                                                        ? Colors.red
                                                                        : detailCheckInTimes[index].type == 1
                                                                            ? _checkInColor
                                                                            : _checkOutColor),
                                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                              ),
                                                              child: Text(
                                                                detailCheckInTimes[index].time,
                                                                style: TextStyle(
                                                                    fontSize: 17, fontWeight: FontWeight.w600),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  new Positioned(
                                                    top: 0.0,
                                                    bottom: 0.0,
                                                    left: 34.0,
                                                    child: new Container(
                                                      height: double.infinity,
                                                      width: 2.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  new Positioned(
                                                    top: 25.0,
                                                    left: 25.0,
                                                    child: new Container(
                                                      height: 20.0,
                                                      width: 20.0,
                                                      decoration: new BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: new Container(
                                                          margin: new EdgeInsets.all(5.0),
                                                          height: 12.0,
                                                          width: 12.0,
                                                          decoration: new BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: detailCheckInTimes[index].type == 1
                                                                  ? _checkInColor
                                                                  : _checkOutColor),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                            itemCount: detailCheckInTimes.length,
                                          ),
                                        )
                                      : Container(height: 140, color: Colors.white),
                                  Container(
                                    height: 60,
                                    color: Colors.white,
                                  )
                                ],
                              )
                            : (curOffice!=null && curOffice.canCheckIn==false && detailCheckInTimes.length>0) ?
                            Column(
                              children: [
                                detailCheckInTimes.length > 0
                                    ? ConstrainedBox(
                                  constraints:
                                  BoxConstraints(minHeight: 200),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return new Stack(
                                        children: <Widget>[
                                          new Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 48.0),
                                            child: new Card(
                                              margin: new EdgeInsets
                                                  .symmetric(
                                                  vertical: 2,
                                                  horizontal: 8),
                                              child: new Container(
                                                padding:
                                                EdgeInsets.all(16),
                                                width: double.infinity,
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "Đã điểm danh ${detailCheckInTimes[index].type == 1 ? "vào ca" : "tan ca"} lúc - ",
                                                      textAlign:
                                                      TextAlign
                                                          .start,
                                                      style: TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: !detailCheckInTimes[
                                                            index]
                                                                .isOnTime
                                                                ? Colors
                                                                .red
                                                                : detailCheckInTimes[index].type ==
                                                                1
                                                                ? _checkInColor
                                                                : _checkOutColor),
                                                        borderRadius: BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            5)),
                                                      ),
                                                      child: Text(
                                                        detailCheckInTimes[
                                                        index]
                                                            .time,
                                                        style: TextStyle(
                                                            fontSize:
                                                            17,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          new Positioned(
                                            top: 0.0,
                                            bottom: 0.0,
                                            left: 34.0,
                                            child: new Container(
                                              height: double.infinity,
                                              width: 2.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          new Positioned(
                                            top: 25.0,
                                            left: 25.0,
                                            child: new Container(
                                              height: 20.0,
                                              width: 20.0,
                                              decoration:
                                              new BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: new Container(
                                                  margin: new EdgeInsets
                                                      .all(5.0),
                                                  height: 12.0,
                                                  width: 12.0,
                                                  decoration: new BoxDecoration(
                                                      shape: BoxShape
                                                          .circle,
                                                      color: detailCheckInTimes[
                                                      index]
                                                          .type ==
                                                          1
                                                          ? _checkInColor
                                                          : _checkOutColor),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                    itemCount:
                                    detailCheckInTimes.length,
                                  ),
                                )
                                    : Container(
                                    height: 140, color: Colors.white),
                                Container(
                                  height: 60,
                                  color: Colors.white,
                                )
                              ],
                            ):(curOffice == null)
                                ? Container(
                                    height: MediaQuery.of(context).size.height * 0.6,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 48),
                                  )
                                : _dayOffPage,
                      ),
                    ],
                  ),
                ),
                Observer(builder: (_) {
                  if (_checkInStore.isLoading)
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height < heightScreen.height ? heightScreen.height: MediaQuery.of(context).size.height,
                      color: Colors.black45,
                      child: SpinKitCircle(
                        color: _color,
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget get _dayOffPage {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        (_color == _checkOutColor)
            ? Image.asset("assets/empty_icon_check_out.PNG")
            : Image.asset("assets/empty_icon.PNG"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hôm nay là ngày nghỉ.\nBạn không cần phải điểm danh",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        Container(height: 60,)
      ],
    );
  }

  CheckInParam getCheckInParam() {
    return new CheckInParam(
        username: userInfo.username,
        companyId: userInfo.companyId,
        clientTime: DateTime.now().millisecondsSinceEpoch,
        latitude: _curPosition.latitude,
        longitude: _curPosition.longitude,
        officeId: curOffice.officeId,
        type: detailCheckInTimes.length == 0 ? 1 : detailCheckInTimes[detailCheckInTimes.length - 1].type == 1 ? 2 : 1,
        usedWifi: _connectionStatus.compareTo("wifi") == 0 ? true : false,
        ip: _connectionStatus.compareTo("wifi") == 0 ? wifiIP : '');
  }

  CheckInParam getCheckInParamQR(QRCodeData data) {
    return new CheckInParam(
        username: userInfo.username,
        companyId: userInfo.companyId,
        clientTime: data.genTime,
        latitude: 0,
        longitude: 0,
        officeId: data.officeId,
        type: detailCheckInTimes.length == 0 ? 1 : detailCheckInTimes[detailCheckInTimes.length - 1].type == 1 ? 2 : 1,
        qrCodeId: data.qrCodeId,
        usedWifi: _connectionStatus.compareTo("wifi") == 0 ? true : false,
        ip: _connectionStatus.compareTo("wifi") == 0 ? wifiIP : '');
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      checkInQR();
    });
  }

  Widget _checkInButton(bool isCompanyZone) {
    return GestureDetector(
      onTap: (!isInCompanyZone || isOffDay)
          ? null
          : () async {
              if (isInCompanyZone) AppDialog.showDialogYN(context, "Bạn muốn điểm danh ra/vào ?", (){
                _checkInStore.checkIn(getCheckInParam());
              }, (){
              });
            },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: (isCompanyZone && !isOffDay) ? _color : _disableColor, width: 2)),
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              ClipOval(
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: (isCompanyZone && !isOffDay) ? _colorGradient : _disableGradient,
                    durations: [20000, 19440],
                    heightPercentages: [0.4, 0.45],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  backgroundColor: (isCompanyZone && !isOffDay) ? _color : _disableColor,
                  size: Size(MediaQuery.of(context).size.width / 2.25, MediaQuery.of(context).size.width / 2.25),
                ),
              ),
              Text("Điểm danh",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
            ],
          ),
        ),
      ),
    );
  }

  void checkInQR() {
    QRCodeData data = QRCodeData.fromJson(jsonDecode(_scanBarcode));
    _checkInStore.checkInQR(getCheckInParamQR(data));
  }
}
