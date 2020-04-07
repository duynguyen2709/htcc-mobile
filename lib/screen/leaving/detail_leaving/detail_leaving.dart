import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:hethongchamcong_mobile/screen/leaving/detail_leaving/detail_leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class DetailLeavingScreen extends StatefulWidget {
  final FormLeaving formLeaving;

  DetailLeavingScreen({this.formLeaving});

  @override
  _DetailLeavingScreenState createState() => _DetailLeavingScreenState();
}

class _DetailLeavingScreenState extends State<DetailLeavingScreen> {
  FormLeaving formLeaving;

  DetailLeavingStore detailLeavingStore;

  @override
  void initState() {
    super.initState();
    detailLeavingStore = DetailLeavingStore();

    formLeaving = widget.formLeaving;

    reaction((_) => detailLeavingStore.msg, (String msg) {
      if (msg != null) {
        _showErrorDialog(msg);
      }
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(Constants.titleErrorDialog),
          content: Text(errorMessage),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(Constants.buttonErrorDialog),
              onPressed: () {
                //Chưa xử lý pop ra main_screen
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Xin nghỉ phép"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Hoàn tất",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              detailLeavingStore.submit(formLeaving);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
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
                  rows: (formLeaving.detail == null)
                      ? null
                      : formLeaving.detail.map((value) {
                          return DataRow(cells: <DataCell>[
                            DataCell(Text(
                              DateFormat('dd-MM-yyyy').format(value.date),
                              style: TextStyle(
                                  fontSize: 14,
                                  decoration: value.isCheck ? TextDecoration.none : TextDecoration.lineThrough),
                            )),
                            DataCell(
                                Text(
                                  getStateByFlag(value.session),
                                  style: TextStyle(
                                      fontSize: 14,
                                      decoration: value.isCheck ? TextDecoration.none : TextDecoration.lineThrough),
                                ),
                                showEditIcon: true, onTap: () async {
                              if (value.isCheck)
                                displayDialog(context, value.session, value).then((_) {
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
          Observer(builder: (_) {
            if (detailLeavingStore.isLoading)
              return LoadingScreen();
            else
              return Center();
          }),
        ],
      ),
    );
  }

  Future<void> displayDialog(BuildContext context, int _currentIndex, Detail detail) async {
    int saveFlag = detail.session;
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
}
