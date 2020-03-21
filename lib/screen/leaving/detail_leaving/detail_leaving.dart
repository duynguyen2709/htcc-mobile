import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:intl/intl.dart';

class DetailLeavingScreen extends StatefulWidget {
  final List<FormDate> listFormDate;

  DetailLeavingScreen({this.listFormDate});

  @override
  _DetailLeavingScreenState createState() => _DetailLeavingScreenState();
}

class _DetailLeavingScreenState extends State<DetailLeavingScreen> {
  List<FormDate> listFormDate;

  @override
  void initState() {
    super.initState();
    listFormDate = widget.listFormDate;
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DataTable(
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
              rows: listFormDate.map((value) {
                return DataRow(cells: <DataCell>[
                  DataCell(Text(
                    DateFormat('dd-MM-yyyy').format(value.dateTime),
                    style: TextStyle(
                        fontSize: 14, decoration: value.isCheck ? TextDecoration.none : TextDecoration.lineThrough),
                  )),
                  DataCell(
                      Text(
                        getStateByFlag(value.flag),
                        style: TextStyle(
                            fontSize: 14, decoration: value.isCheck ? TextDecoration.none : TextDecoration.lineThrough),
                      ),
                      showEditIcon: true, onTap: () async {
                    if (value.isCheck)
                      displayDialog(context, value.flag, value).then((_) {
                        setState(() {});
                      });
                  }),
                  DataCell(Center(
                    child: IconButton(
                      icon: value.isCheck
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.remove_circle,
                              color: Colors.red,
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
          ],
        ),
      ),
    );
  }

  Future<void> displayDialog(BuildContext context, int _currentIndex, FormDate formDate) async {
    int saveFlag = formDate.flag;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Chọn buổi'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    children: <Widget>[
                      RadioListTile(
                        title: Text("Cả ngày"),
                        groupValue: _currentIndex,
                        value: 0,
                        onChanged: (value) {
                          setState(() {
                            _currentIndex = value;
                            formDate.flag = value;
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
                            formDate.flag = value;
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
                            formDate.flag = value;
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
                  formDate.flag = saveFlag;
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

  String getStateByFlag(int flag) {
    switch (flag) {
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
}
