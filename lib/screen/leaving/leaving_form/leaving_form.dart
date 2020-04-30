import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_form/leaving_form_store.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/custom_expansion_tile.dart';
import 'package:hethongchamcong_mobile/utils/MeasureSize.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeavingFormScreen extends StatefulWidget {
  final LeavingStore store;

  LeavingFormScreen({this.store});

  @override
  _LeavingFormScreenState createState() => _LeavingFormScreenState(store);
}

class _LeavingFormScreenState extends State<LeavingFormScreen> {
  DateTime _fromDateTime = DateTime.now();
  DateTime _toDateTime = DateTime.now();
  int num = 5;
  DateTime minTime = DateTime.now();
  bool visibleDate = true;
  FocusScopeNode currentFocus;
  String typeLeaving = "";
  List<DetailSubmitLeaving> detailSubmits;
  TextEditingController controller;
  LeavingFormStore formStore;
  var screenSize = Size.zero;

  final LeavingStore store;

  _LeavingFormScreenState(this.store);

  @override
  void initState() {
    super.initState();
    minTime = DateTime.now();
    controller = TextEditingController();
    formStore = LeavingFormStore();
    detailSubmits = calculateDaysInterval(_fromDateTime, _toDateTime);
    reaction((_) => formStore.isSubmitSuccess, (isSuccess) async {
      if(isSuccess!=null)
        if (isSuccess) {
        _showDialog(formStore.msg, isPopBack: true);
        } else {
        _showDialog(formStore.msg);
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    currentFocus = FocusScope.of(context);
//
    return Scaffold(
      backgroundColor: Color(0xEEEEEEEE),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Xin nghỉ phép"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MeasureSize(
          onChange: (size){
            screenSize =size;
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Wrap(
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Loại nghỉ phép ',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17),
                                            ),
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                  color: Colors.blue, fontSize: 17),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      items: store.leavingData.categories
                                          .map((String val) {
                                        return DropdownMenuItem<String>(
                                          value: val,
                                          child: new Text(val,
                                              style: TextStyle(fontSize: 17)),
                                        );
                                      }).toList(),
                                      value:
                                          typeLeaving == '' || typeLeaving == null
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
                                    padding: const EdgeInsets.only(top: 4),
                                    child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Thời gian ',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17),
                                            ),
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                  color: Colors.blue, fontSize: 17),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 4),
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: InkWell(
                                              child: Card(
                                                  child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16, horizontal: 8),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.grey,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                      "${DateFormat('dd-MM-yyyy').format(_fromDateTime)}",
                                                      textAlign: TextAlign.center,
                                                      style:
                                                          TextStyle(fontSize: 16),
                                                    )),
                                                  ],
                                                ),
                                              )),
                                              onTap: () {
                                                DatePicker.showDatePicker(context,
                                                    showTitleActions: true,
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  minTime = date;
                                                  _fromDateTime = date;
                                                  _toDateTime
                                                          .isBefore(_fromDateTime)
                                                      ? _toDateTime = _fromDateTime
                                                      : _toDateTime = _toDateTime;
                                                  detailSubmits =
                                                      calculateDaysInterval(
                                                          _fromDateTime,
                                                          _toDateTime);
                                                },
                                                    currentTime: DateTime.now(),
                                                    locale: LocaleType.vi,
                                                    minTime: DateTime.now());
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              child: Card(
                                                  child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16, horizontal: 8),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.grey,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                      "${DateFormat('dd-MM-yyyy').format(_toDateTime)}",
                                                      textAlign: TextAlign.center,
                                                      style:
                                                          TextStyle(fontSize: 16),
                                                    )),
                                                  ],
                                                ),
                                              )),
                                              onTap: () {
                                                DatePicker.showDatePicker(context,
                                                    showTitleActions: true,
                                                    onChanged: (date) {},
                                                    onConfirm: (date) {
                                                  _toDateTime = date;
                                                  detailSubmits =
                                                      calculateDaysInterval(
                                                          _fromDateTime,
                                                          _toDateTime);
                                                },
                                                    currentTime: DateTime.now(),
                                                    locale: LocaleType.vi,
                                                    minTime:
                                                        minTime ?? DateTime.now(),
                                                    maxTime: (minTime != null)
                                                        ? minTime.add(
                                                            Duration(days: num - 1))
                                                        : DateTime.now().add(
                                                            Duration(
                                                                days: num - 1)));
                                              },
                                            ),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Lý do ',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 17),
                                            ),
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                  color: Colors.blue, fontSize: 17),
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
                                        borderSide:
                                            BorderSide(color: Color(0xEED5D5D5)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Color(0xEED5D5D5)),
                                      ),
                                    ),
                                  ),
                                  ListTileTheme(
                                    contentPadding: EdgeInsets.all(0),
                                    child: ExpansionTile(
                                      initiallyExpanded: true,
                                      title: Text("Chi tiết"),
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          child:DataTable(
                                            horizontalMargin: 10,
                                            columnSpacing: 10,
                                            columns: <DataColumn>[
                                              DataColumn(
                                                  label: Text(
                                                    "Ngày",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                                  )),
                                              DataColumn(
                                                  label: Text(
                                                    "Thời gian nghỉ",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                                                  )),
                                              DataColumn(
                                                  label: Text(
                                                    "",
                                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                  ))
                                            ],
                                            rows: detailSubmits.map((value) {
                                              return DataRow(
                                                  key: Key(
                                                      value.date.toIso8601String()),
                                                  cells: <DataCell>[
                                                    DataCell(Text(
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(value.date),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      decoration: value.isCheck ? TextDecoration.none : TextDecoration.lineThrough
                                                      ),
                                                    )),
                                                    DataCell(
                                                        Text(
                                                          getStateByFlag(
                                                              value.session),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                              decoration: value.isCheck ? TextDecoration.none : TextDecoration.lineThrough),
                                                        ),
                                                        showEditIcon: true,
                                                        onTap: () async {
                                                      if (value.isCheck)
                                                        displayDialog(
                                                                context,
                                                                value.session,
                                                                value)
                                                            .then((_) {
                                                          setState(() {});
                                                        });
                                                    }),
                                                    DataCell(Center(
                                                      child: IconButton(
                                                        icon: value.isCheck
                                                            ? Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.red,
                                                        )
                                                            : Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            value.isCheck = !value.isCheck;
                                                          });
                                                        },
                                                      ),
                                                    ))
                                                  ]);
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 24,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                              color: Colors.blue,
                              onPressed: () {
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
                                    if (jsonUser != null && jsonUser.isNotEmpty) {
                                      User user =
                                          User.fromJson(json.decode(jsonUser));
                                      FormLeaving formLeaving = FormLeaving(
                                          category: typeLeaving,
                                          clientTime:
                                              DateTime.now().millisecondsSinceEpoch,
                                          companyId: user.companyId,
                                          detail: detailSubmits,
                                          reason: controller.text,
                                          username: user.username);
                                      formStore.submit(formLeaving);
                                    }
                                  });
                                }
                              },
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                              child: Text(
                                "Gửi đơn",
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Observer(
                  builder: (_) {
                    if (formStore.isLoadingSubmitForm)
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: screenSize.height,
                        color: Colors.black45,
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      );
                    else
                      return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(String message, {bool isPopBack = false}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(""),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                if(formStore.errAuth) {
                  Navigator.pushReplacementNamed(
                      context, Constants.login_screen);
                }
                else if(isPopBack)  Navigator.pop(context,'Success');
              },
            ),
          ],
        );
      },
    );


  }

  String getStateByFlag(int session) {
    switch (session) {
      case 0:
        return "Cả ngày";
      case 1:
        return "Buổi sáng";
      case 2:
        return "Buổi chiều";
      default:
        return "Cả ngày";
    }
  }

  Future<void> displayDialog(BuildContext context, int _currentIndex,
      DetailSubmitLeaving detail) async {
    int saveFlag = detail.session;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text('Chọn buổi'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RadioListTile(
                        title: Text("Cả ngày"),
                        groupValue: _currentIndex,
                        value: 0,
                        onChanged: (value) {
                          setState(() {
                            _currentIndex = value;
                            detail.session = value;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Buổi sáng"),
                        groupValue: _currentIndex,
                        value: 1,
                        onChanged: (value) {
                          setState(() {
                            _currentIndex = value;
                            detail.session = value;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Buổi chiều"),
                        groupValue: _currentIndex,
                        value: 2,
                        onChanged: (value) {
                          setState(() {
                            _currentIndex = value;
                            detail.session = value;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  detail.session = saveFlag;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<DetailSubmitLeaving> calculateDaysInterval(
      DateTime startDate, DateTime endDate) {
    List<DetailSubmitLeaving> result = [];
    if (startDate.day == endDate.day &&
        startDate.year == endDate.year &&
        startDate.month == endDate.month) {
      result.add(DetailSubmitLeaving(date: startDate, session: 0));
      return result;
    }
    var count = endDate.difference(startDate).inDays;
    for (int i = 0; i <= count; i++) {
      result.add(DetailSubmitLeaving(
          date: startDate.add(Duration(days: i)), session: 0));
    }
    return result;
  }
}
