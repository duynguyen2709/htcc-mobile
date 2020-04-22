import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/event_detail.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_request_screen.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/custom_expansion_tile.dart';
import 'package:hethongchamcong_mobile/screen/widget/marquee_widget.dart';
import 'package:hethongchamcong_mobile/screen/widget/round_text.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_calendar.dart';

class InfoLeavingScreen extends StatefulWidget {
  final LeavingStore leavingStore;
  final MainScreenState mainScreenInstance;

  InfoLeavingScreen({this.leavingStore, this.mainScreenInstance});

  @override
  _InfoLeavingScreenState createState() =>
      _InfoLeavingScreenState(mainScreenInstance);
}

class _InfoLeavingScreenState extends State<InfoLeavingScreen> {
  LeavingStore _leavingStore;
  int stateOfFooter = 0;
  final MainScreenState mainScreenInstance;
  GlobalKey<MyCalendarState> _calendarKey = GlobalKey();
  List<EventDetail> events = List();
  List<Color> colorList = [
    Colors.red,
    Colors.blue,
  ];

  Map<String, double> dataMap = new Map();

  Map<int, Widget> mapStatusWidget = {
    0: RoundText(
      title: "REJECTED",
      colorText: Colors.white,
      colorBackground: Colors.red,
    ),
    1: RoundText(
      title: "APPROVED",
      colorText: Colors.white,
      colorBackground: Colors.green,
    ),
    2: RoundText(
      title: "SPENDING",
      colorText: Colors.white,
      colorBackground: Colors.grey,
    ),
  };
  Map<int, Color> mapColorStatus = {
    1: Colors.lightGreenAccent,
    2: Color(0xEEF9AE33),
    0: Colors.red
  };

  var typeLeaving = "";
  var timeLeaving = "Cả ngày";
  var _optionLeaving = ["Cả ngày", "Buổi sáng", "Buổi chiều"];
  DateTime selectedDate;

  TextEditingController controller;

  _InfoLeavingScreenState(this.mainScreenInstance);

  @override
  void initState() {
    super.initState();
    _leavingStore = widget.leavingStore;
    controller = TextEditingController();
    var formatter = new DateFormat('yyyy-MM-dd');
    reaction((_) => _leavingStore.isSubmitSuccess, (isSuccess) {
      if (isSuccess != null && mounted) _showDialog(_leavingStore.errorMsg);
      if (isSuccess == true) {
        _leavingStore.loadData();
      }
    });
    reaction((_) => _leavingStore.isLoading, (isLoading) {
      if (!isLoading && _leavingStore.leavingData != null)
        setState(() {
          if (_leavingStore.year == DateTime.now().year) {
            selectedDate = DateTime.now();
            if (_leavingStore.listEvent[
                        formatter.parse(formatter.format(DateTime.now()))] ==
                    null ||
                _leavingStore
                        .listEvent[
                            formatter.parse(formatter.format(DateTime.now()))]
                        .length ==
                    0) {
              setState(() {
                stateOfFooter = 0;
              });
            } else
              setState(() {
                stateOfFooter = 1;
                this.events = _leavingStore.listEvent[
                    formatter.parse(formatter.format(DateTime.now()))];
              });
          } else {
            selectedDate = DateTime(_leavingStore.year);
            if (_leavingStore.listEvent[formatter.parse(
                        formatter.format(DateTime(_leavingStore.year)))] ==
                    null ||
                _leavingStore
                        .listEvent[formatter.parse(
                            formatter.format(DateTime(_leavingStore.year)))]
                        .length ==
                    0) {
              setState(() {
                stateOfFooter = 2;
              });
            } else
              setState(() {
                stateOfFooter = 1;
                this.events = _leavingStore.listEvent[formatter
                    .parse(formatter.format(DateTime(_leavingStore.year)))];
              });
          }
        });
    });

    reaction((_) => _leavingStore.isCancelSuccess, (isSuccess) {
      if(isSuccess!=null) {_showDialog(_leavingStore.errorMsg);}
      if(isSuccess==true) _leavingStore.loadData();
    });
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(""),
          content: Text(message != null ? message : ""),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                if(_leavingStore.errAuth){
                  Navigator.pushReplacementNamed(
                      context, Constants.login_screen);
                }
              },
            ),
          ],
        );
      },
    );
  }

  openAlertCancelRequest(Function onContinue) {
    String content = "";
    content = "Bạn muốn hủy đơn xin nghỉ phép ?";
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
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              onContinue();
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
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue,
                    Colors.lightBlueAccent,
                    Colors.lightBlueAccent,
                    Colors.blue,
                  ]),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.body1,
                                  children: [
                                    TextSpan(
                                      text: 'Thống kê',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 23, right: 8, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                          width: 0.5, color: Colors.white)),
                                  child: Row(
                                    children: <Widget>[
                                      Observer(
                                        builder: (BuildContext context) {
                                          return Text(
                                            _leavingStore.year.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          );
                                        },
                                      ),
                                      Icon(Icons.arrow_drop_down,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  selectYear(context, _leavingStore.year);
                                },
                              )
                            ],
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 140,
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                width: 140,
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${_leavingStore.leavingData.totalDays != null ? _leavingStore.leavingData.totalDays : 0.0}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            "TỔNG NGÀY PHÉP",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                width: 140,
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${_leavingStore.leavingData.usedDays != null ? _leavingStore.leavingData.usedDays : 0.0}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                          "NGHỈ PHÉP",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 15),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                width: 140,
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${_leavingStore.leavingData.leftDays != null ? _leavingStore.leavingData.leftDays : 0.0}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                          "CÒN LẠI",
                                          style: TextStyle(
                                              color: Color(0xEEFF9A00),
                                              fontSize: 15),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                width: 140,
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${_leavingStore.leavingData.externalDaysOff != null ? _leavingStore.leavingData.externalDaysOff : 0.0}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                          "NGHỈ KHÔNG PHÉP",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LeavingRequestScreen(
                                                store: _leavingStore)),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: 140,
                                  child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.white70, width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.blue,
                                            size: 40,
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Text(
                                            "CHI TIẾT",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ]),
                      ),
                      Divider(
                          endIndent: 20,
                          thickness: 1,
                          indent: 20,
                          color: Color(0xEED5D5D5)),
                      MyCalendar(
                        key: _calendarKey,
                        num: 10,
                        events: _leavingStore.listEvent,
                        year: _leavingStore.year,
                        onDaySelected: (events, date) {
                          selectedDate = date;
                          if (date.isBefore(DateTime.now()) &&
                              (events == null || events.length == 0))
                            setState(() {
                              stateOfFooter = 2;
                            });
                          else if (events == null || events.length == 0)
                            setState(() {
                              stateOfFooter = 0;
                            });
                          else
                            setState(() {
                              stateOfFooter = 1;
                              this.events = events;
                            });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: stateOfFooter == 1
                      ? Stack(
                          children: <Widget>[
                            _getEventInfoList(events),
                            (!selectedDate.isBefore(DateTime.now()) ||
                                    (selectedDate.day == DateTime.now().day &&
                                        selectedDate.month ==
                                            DateTime.now().month &&
                                        selectedDate.year ==
                                            DateTime.now().year))
                                ? Positioned(
                                    top: 4,
                                    right: 48,
                                    child: Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.lightBlue,
                                          border: Border.all(
                                              color: Colors.white, width: 3)),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              Constants.leaving_form_screen,
                                              arguments: _leavingStore);
                                        },
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      : stateOfFooter == 0
                          ? createLeavingForm
                          : _getEventInfoList(List()),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _refresh() async {
    _leavingStore.loadData();
  }

  Widget get createLeavingForm => Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.white),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Loại nghỉ phép ',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 17),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items:
                        _leavingStore.leavingData.categories.map((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: new Text(val, style: TextStyle(fontSize: 17)),
                      );
                    }).toList(),
                    value: typeLeaving == '' || typeLeaving == null
                        ? null
                        : typeLeaving,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        typeLeaving = newValue;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Thời gian nghỉ ',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 17),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: _optionLeaving.map((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: new Text(val, style: TextStyle(fontSize: 17)),
                      );
                    }).toList(),
                    value: timeLeaving,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        timeLeaving = newValue;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Lý do ',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 17),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        ],
                      )),
                ),
                TextField(
                  minLines: 2,
                  maxLines: 50,
                  textAlign: TextAlign.left,
                  controller: controller,
                  decoration: new InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xEED5D5D5)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xEED5D5D5)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 64,
                    height: 64,
                    margin: EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.lightBlue),
                    child: Observer(
                      builder: (context) {
                        if (_leavingStore.isLoadingSubmitForm)
                          return CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          );
                        else
                          return IconButton(
                            icon: Transform.rotate(
                              angle: -pi / 4,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            onPressed: () {
                              if (controller.text.isEmpty) {
                                _showDialog(
                                    "Vui lòng điền lý do xin nghỉ phép để tiếp tục.");
                              } else if (typeLeaving == null ||
                                  typeLeaving.compareTo("") == 0) {
                                _showDialog(
                                    "Vui lòng chọn loại nghỉ phép để tiếp tục");
                              } else {
                                if (controller.text.isEmpty) {
                                  _showDialog(
                                      "Vui lòng điền lý do xin nghỉ phép để tiếp tục.");
                                } else if (typeLeaving == null ||
                                    typeLeaving.compareTo("") == 0) {
                                  _showDialog(
                                      "Vui lòng chọn loại nghỉ phép để tiếp tục");
                                } else {
                                  SharedPreferences.getInstance().then((pref) {
                                    String jsonUser =
                                        pref.getString(Constants.USER);
                                    if (jsonUser != null &&
                                        jsonUser.isNotEmpty) {
                                      User user =
                                          User.fromJson(json.decode(jsonUser));
                                      FormLeaving formLeaving = FormLeaving(
                                          category: typeLeaving,
                                          clientTime: DateTime.now()
                                              .millisecondsSinceEpoch,
                                          companyId: user.companyId,
                                          detail: [
                                            DetailSubmitLeaving(
                                                date: selectedDate,
                                                session: _optionLeaving
                                                    .indexOf(timeLeaving))
                                          ],
                                          reason: controller.text,
                                          username: user.username);
                                      _leavingStore.submit(formLeaving);
                                      controller.text="";
                                      typeLeaving=_leavingStore.leavingData.categories[0];
                                      timeLeaving = _optionLeaving[0];
                                    }
                                  });
                                }
                              }
                            },
                          );
                      },
                    ),
                  ),
                ),
                Container(
                  height: 60,
                )
              ],
            ),
          ),
        ],
      );

  Widget _getEventInfoList(List events) => Column(
        children: <Widget>[
          Container(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.white),
            padding: EdgeInsets.only(top: 28),
            child: Column(
              children: <Widget>[
                Column(
                  children: events
                      .map((event) => Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomExpansionTile(
                            initiallyExpanded: false,
                            title: MarqueeWidget(
                              direction: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: mapColorStatus[
                                              event.statusRequest]),
                                      width: 8,
                                      height: 8,
                                    ),
                                  ),
                                  Text(
                                    "Mã đơn : ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    event.belongToRequestID,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text("Trạng thái:",
                                                style: TextStyle(fontSize: 16)),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: mapColorStatus[
                                                    event.statusRequest],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 12),
                                            child: Text(
                                              event.getStatus(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                            "Thời gian nghỉ:",
                                            style: TextStyle(fontSize: 16),
                                          )),
                                          Text(event.getSession(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text("Được tạo ngày:",
                                                  style:
                                                      TextStyle(fontSize: 16))),
                                          Text(event.createAt,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text("Lý do:",
                                                  style:
                                                      TextStyle(fontSize: 16))),
                                          Text(event.reason,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    (event.approver == null ||
                                            event.approver.isEmpty)
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                    child: Text("Người duyệt:",
                                                        style: TextStyle(
                                                            fontSize: 16))),
                                                Text(event.approver,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          ),
                                    event.statusRequest == 2
                                        ? Center(
                                            child: RaisedButton(
                                            color: Color(0xEEFF9A00),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 32),
                                            onPressed: () {
                                              openAlertCancelRequest(() {
                                                String date = DateFormat(
                                                        "yyyyMMdd")
                                                    .format(DateFormat(
                                                            "dd/MM/yyyy")
                                                        .parse((event
                                                                as EventDetail)
                                                            .createAt));
                                                _leavingStore.cancel(
                                                    (event as EventDetail)
                                                        .belongToRequestID
                                                        .replaceAll("#", ""),
                                                    date);
                                              });
                                            },
                                            textColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10.0)),
                                            child: Observer(
                                              builder: (context) {
                                                if (_leavingStore
                                                    .isLoadingCancel)
                                                  return SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            new AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                      ));
                                                else
                                                  return Text(
                                                    "Hủy đơn",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  );
                                              },
                                            ),
                                          ))
                                        : Container()
                                  ],
                                ),
                              )
                            ],
                          )))
                      .toList(),
                ),
                Container(
                  height: 60,
                )
              ],
            ),
          ),
        ],
      );

  void selectYear(context, int year) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: YearPicker(
            selectedDate: DateTime(year),
            firstDate: DateTime(1990),
            lastDate: DateTime.now(),
            onChanged: (val) {
              _leavingStore.year = val.year;
              _leavingStore.loadData();
              _calendarKey.currentState.changeYear(val.year);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
