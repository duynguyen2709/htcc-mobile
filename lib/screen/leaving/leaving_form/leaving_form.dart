import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_form/calendar.dart';
import 'package:intl/intl.dart';

import 'leaving_form_store.dart';

class LeavingFormScreen extends StatefulWidget {
  @override
  _LeavingFormScreenState createState() => _LeavingFormScreenState();
}

class _LeavingFormScreenState extends State<LeavingFormScreen> {
  LeavingFormStore _leavingFormStore;
  TextEditingController _reasonController;
  TextEditingController _fromController;
  TextEditingController _toController;
  DateTime _fromDateTime;
  DateTime _toDateTime;
  int _groupValue = 0;
  int num = 5;
  final _formKey = GlobalKey<FormState>();
  DateTime minTime;
  bool visibleDate = true;
  bool visibleCalendar = false;
  FocusScopeNode currentFocus;

  @override
  void initState() {
    super.initState();
    _leavingFormStore = LeavingFormStore();
    _leavingFormStore.init();
    _reasonController = TextEditingController();
    _fromController = TextEditingController();
    _toController = TextEditingController();
    minTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    currentFocus = FocusScope.of(context);
    return Scaffold(
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.black45))),
                child: ListTile(
                  title: Text(
                    "Chọn ngày liên tục",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: Colors.blue,
                    groupValue: _groupValue,
                    onChanged: (value) {
                      setState(() {
                        _groupValue = value;
                        visibleDate = !visibleDate;
                        visibleCalendar = !visibleCalendar;
                      });
                    },
                    value: 0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: AnimatedContainer(
                  height: visibleDate ? 100 : 1,
                  child: AnimatedOpacity(
                    opacity: visibleDate ? 1 : 0,
                    duration: Duration(milliseconds: 500),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        enableInteractiveSelection: false,
                                        controller: _fromController,
                                        validator: _validate,
                                        enabled: false,
                                        decoration: InputDecoration(labelText: "Từ"),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.date_range),
                                      onPressed: (visibleDate)
                                          ? () {
                                              {
                                                DatePicker.showDatePicker(context,
                                                    showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
                                                  minTime = date;
                                                  _fromController.text = DateFormat('dd-MM-yyyy').format(date);
                                                  _toController.text = "";
                                                  _fromDateTime = date;
                                                },
                                                    currentTime: DateTime.now(),
                                                    locale: LocaleType.vi,
                                                    minTime: DateTime.now());
                                              }
                                            }
                                          : null,
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      controller: _toController,
                                      validator: _validate,
                                      enabled: false,
                                      decoration: InputDecoration(labelText: "Đến"),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.date_range),
                                    onPressed: (visibleDate)
                                        ? () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
                                              _toController.text = DateFormat('dd-MM-yyyy').format(date);
                                              _toDateTime = date;
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.vi,
                                                minTime: minTime ?? DateTime.now(),
                                                maxTime: (minTime != null)
                                                    ? minTime.add(Duration(days: num - 1))
                                                    : DateTime.now().add(Duration(days: num - 1)));
                                          }
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  duration: Duration(milliseconds: 500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.black45))),
                child: ListTile(
                  title: Text(
                    "Chọn ngày theo lịch",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: Colors.blue,
                    groupValue: _groupValue,
                    onChanged: (value) {
                      setState(() {
                        _groupValue = value;
                        visibleDate = !visibleDate;
                        visibleCalendar = !visibleCalendar;
                      });
                    },
                    value: 1,
                  ),
                ),
              ),
              AnimatedContainer(
                height: visibleCalendar ? MediaQuery.of(context).size.height * 2 / 5 : 1,
                child: AnimatedOpacity(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: _buildTableCalendarWithBuilders(),
                  ),
                  duration: Duration(milliseconds: 500),
                  opacity: visibleCalendar ? 1 : 0,
                ),
                duration: Duration(milliseconds: 500),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _reasonController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      hintText: 'Lí do',
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Tiếp tục",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    switch (_groupValue) {
                      case 0:
                        {
                          if (_formKey.currentState.validate()) {
                            List<FormDate> listFormDate = List();
                            calculateDaysInterval(_fromDateTime, _toDateTime).forEach((value) {
                              listFormDate.add(FormDate(dateTime: value, flag: 0));
                            });
                            Navigator.of(context).pushNamed(Constants.detail_leaving_screen, arguments: listFormDate);
                          }
                          break;
                        }
                      case 1:
                        {
                          List<FormDate> listFormDate = List();
                          _leavingFormStore.listBooking.forEach((value) {
                            listFormDate.add(FormDate.convert(value));
                          });
                          Navigator.of(context).pushNamed(Constants.detail_leaving_screen, arguments: listFormDate);
                        }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return SingleChildScrollView(
      physics: visibleCalendar ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(),
      child: Calendar(
        leavingFormStore: _leavingFormStore,
        num: num,
      ),
    );
  }

  String _validate(value) {
    try {
      DateTime formDate;
      DateTime toDate;
      formDate = DateFormat('dd-MM-yyyy').parse(_fromController.text);
      toDate = DateFormat('dd-MM-yyyy').parse(_toController.text);
      if (toDate.difference(formDate).inDays > num - 1) return "Nghỉ quá nhiều";
      return null;
    } catch (error) {
      return "Sai định dạng ngày";
    }
  }

  List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    if (startDate.day == endDate.day && startDate.year == endDate.year && startDate.month == endDate.month) {
      days.add(startDate);
      return days;
    }
    int tmp = 0;
    if (startDate.hour > 0 ||
        startDate.minute > 0 ||
        startDate.second > 0 ||
        startDate.millisecond > 0 ||
        startDate.microsecond > 0) {
      tmp = 1;
    }
    for (int i = 0; i <= endDate.difference(startDate).inDays + tmp; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }
}
