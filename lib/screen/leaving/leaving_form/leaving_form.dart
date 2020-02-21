import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  TextEditingController _formController;
  TextEditingController _toController;
  int _groupValue = 0;
  DateTime formDate;
  DateTime toDate;
  int num = 5;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _leavingFormStore = LeavingFormStore();
    _leavingFormStore.init();
    _reasonController = TextEditingController();
    _formController = TextEditingController();
    _toController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _reasonController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    hintText: 'Lí do',
                  ),
                ),
              ),
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Cách chọn ngày nghỉ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            ListTile(
              title: Text("Chọn ngày liên tục"),
              leading: Radio(
                groupValue: _groupValue,
                onChanged: (value) {
                  setState(() {
                    _groupValue = value;
                  });
                },
                value: 0,
              ),
            ),
            (_groupValue == 0)
                ? Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _formController,
                              validator: _validate,
                              enabled: (_groupValue == 0) ? true : false,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.date_range),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        _formController.text =
                                            DateFormat('dd-MM-yyyy')
                                                .format(date);
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                  ),
                                  labelText: "Từ"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              controller: _toController,
                              validator: _validate,
                              enabled: (_groupValue == 0) ? true : false,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.date_range),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        _toController.text =
                                            DateFormat('dd-MM-yyyy')
                                                .format(date);
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                  ),
                                  labelText: "Đến"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(),
            ListTile(
              title: Text("Chọn ngày theo lịch"),
              leading: Radio(
                groupValue: _groupValue,
                onChanged: (value) {
                  setState(() {
                    _groupValue = value;
                  });
                },
                value: 1,
              ),
            ),
            (_groupValue == 1)
                ? Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: _buildTableCalendarWithBuilders(),
                  )
                : Center(),
            Container(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              width: double.infinity,
              child: RaisedButton(
                child: Text("Gửi"),
                onPressed: () {
                  if (_groupValue == 1) {
                    if (_formKey.currentState.validate()) {}
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return Calendar(
      leavingFormStore: _leavingFormStore,
      num: num,
    );
  }

  String _validate(value) {
    try {
      formDate = DateFormat('dd-MM-yyyy').parse(_formController.text);
      toDate = DateFormat('dd-MM-yyyy').parse(_toController.text);
      if (formDate.compareTo(toDate) >= 0) return "Sai định dạng ngày";
      if (toDate.difference(formDate).inDays > num - 1) return "Nghỉ quá nhiều";
      return null;
    } catch (error) {
      return "Sai định dạng ngày";
    }
  }
}
