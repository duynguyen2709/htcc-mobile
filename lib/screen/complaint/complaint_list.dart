import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/complaint.dart';
import 'package:hethongchamcong_mobile/screen/complaint/complaint_detail.dart';
import 'package:hethongchamcong_mobile/screen/widget/image_picker.dart';
import 'package:hethongchamcong_mobile/screen/widget/paged_list_view.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import 'complaint_store.dart';

class ComplaintList extends StatefulWidget {
  final ComplaintStore store;
  final bool isSuccessList;

  ComplaintList({Key key, this.store, this.isSuccessList}) : super(key: key);

  @override
  ComplaintListState createState() => ComplaintListState(store, isSuccessList);
}

class ComplaintListState extends State<ComplaintList>
    with AutomaticKeepAliveClientMixin<ComplaintList> {
  bool isAnonymously = false;
  final ComplaintStore store;
  final bool isSuccessList;

  bool isEmpty = true;
  bool isError = false;
  List<Complaint> list = List();

  ComplaintListState(this.store, this.isSuccessList);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(store.listComplaint!=null) {
      if (store.listComplaint.length == 0) {
        list = List();
        setState(() {
          isEmpty = true;
          isError = false;
        });
      } else {
        if (isSuccessList)
          list = store.listComplaint
              .where((element) => element.status !=2)
              .toList();
        else
          list = store.listComplaint
              .where((element) => element.status ==2)
              .toList();
        setState(() {
          isEmpty = false;
          isError = false;
        });
      }
    }
    reaction((_) => store.getListComplaintSuccess, (isSuccess) async {
      if (isSuccess == true) {
        if (store.listComplaint.length == 0) {
          list = List();
          setState(() {
            isEmpty = true;
            isError = false;
          });
        } else {
          if (isSuccessList)
            list = store.listComplaint
                .where((element) => element.status !=2)
                .toList();
          else
            list = store.listComplaint
                .where((element) => element.status ==2)
                .toList();
          setState(() {
            isEmpty = false;
            isError = false;
          });
        }
      } else if (isSuccess != null) {
        setState(() {
          isError = true;
        });
      }
    });
  }
  Future<void> _refresh() async {
    return await store.refresh();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    DateTime now = DateTime.now();
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          onRefresh: _refresh,
          child: (isEmpty &&
              DateFormat('yyyyMM')
                  .format(store.monthQuery)
                  .compareTo(DateFormat('yyyyMM').format(now)) ==
                  0)
              ? suggestAddComplaint
              : (!isEmpty)
              ? Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      buildComplaintItem(list[index]),
                  itemCount: list.length,
                ),
              ),
            ],
          )
              : emptyPage,
        )
        ,
        Observer(builder: (_) {
          if (store.isLoading)
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
        })
      ],
    );
  }

  Widget buildComplaintItem(Complaint model) {
    String codeToStatus(int code) {
      switch (code) {
        case 1:
          return 'Đã xử lý';
        case 2:
          return 'Đang xử lý';
        case 0:
          return 'Bị từ chối xử lý';
        default:
          return 'Đang xử lý';
      }
    }

    Color codeToColor(int code) {
      switch (code) {
        case 1:
          return Colors.green;
        case 2:
          return Color(0xEEf3ba00);
        case 0:
          return Colors.red;
        default:
          return Color(0xEEf3ba00);
      }
    }

    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ComplaintDetail(
                    complaint: model,
                  )),
        )
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 18,
                          width: 18,
                          margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: codeToColor(model.status)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    model.complaintId,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 2, 4, 8),
                                  child: Text(
                                    model.content,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xEED5D5D5),
                                  thickness: 1.5,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "${model.date} - ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: codeToColor(model.status),
                                          width: 2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Text(
                                          codeToStatus(model.status),
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: Random().nextInt(100).toDouble(),
                    right: Random().nextInt(100).toDouble() - 40,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: Random().nextInt(100).toDouble() + 40,
                      width: Random().nextInt(100).toDouble() + 40,
                      margin: EdgeInsets.fromLTRB(8, 0, 8, 12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withOpacity(0.4)),
                    ),
                  ),
                  Positioned(
                    top: Random().nextInt(100).toDouble(),
                    right: Random().nextInt(100).toDouble() - 40,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: Random().nextInt(100).toDouble() + 40,
                      width: Random().nextInt(100).toDouble() + 40,
                      margin: EdgeInsets.fromLTRB(8, 0, 8, 12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent.withOpacity(0.3)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get emptyPage {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/empty_icon.PNG"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bạn không có góp ý/ khiếu nại nào.",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get suggestAddComplaint {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Image.asset(
                "./assets/empty_complaint.png",
                height: 300,
                width: MediaQuery.of(context).size.width - 50,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Bạn cần hỗ trợ hoặc góp ý ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: RaisedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Constants.complaint_form);
                      },
                      icon: Icon(
                        Icons.note_add,
                        color: Colors.white,
                      ),
                      label: Text(
                        "TẠO YÊU CẦU/ GÓP Ý",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
