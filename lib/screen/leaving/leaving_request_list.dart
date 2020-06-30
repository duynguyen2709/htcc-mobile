import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/leaving.dart';
import 'package:hethongchamcong_mobile/screen/widget/calendar_cell.dart';
import 'package:hethongchamcong_mobile/screen/widget/custom_expansion_tile.dart';
import 'package:hethongchamcong_mobile/screen/widget/marquee_widget.dart';
import 'package:hethongchamcong_mobile/screen/widget/round_text.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import 'leaving_store.dart';

class LeavingRequestList extends StatefulWidget {
  final LeavingStore store;
  final int code;

  LeavingRequestList({Key key, this.store, this.code})
      : super(key: key);

  @override
  LeavingRequestListState createState() =>
      LeavingRequestListState(store, code);
}

class LeavingRequestListState extends State<LeavingRequestList>
    with AutomaticKeepAliveClientMixin<LeavingRequestList> {
  bool isAnonymously = false;
  final LeavingStore store;
  final int code;

  bool isEmpty = true;
  bool isError = false;
  List<ListRequest> list = List();
  String currentRequestID ="";

  LeavingRequestListState(this.store, this.code);

  void filter(int code){
    if (code!= -1)
      list = store.listRequest
          .where((element) => element.status == code)
          .toList();
    else
      list = store.listRequest;
    setState(() {
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (store.listRequest != null) {
      if (store.listRequest.length == 0) {
        list = List();
        setState(() {
          isEmpty = true;
          isError = false;
        });
      } else {
        if (code!= -1)
          list = store.listRequest
              .where((element) => element.status == code)
              .toList();
        else
          list = store.listRequest;
        setState(() {
          isEmpty = false;
          isError = false;
        });
      }
    }
    reaction((_)=>store.isCancelSuccess, (isSuccess){
      if(isSuccess!=null) {
        store.loadData();
//        _showDialog(store.msg);
      }
    });
    reaction((_)=>store.isLoading, (isLoading){
      if(!isLoading && store.listRequest!=null){
        list = store.listRequest;
        setState(() {

        });
      }
    });
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

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(""),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
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
    // TODO: implement build
    super.build(context);
    DateTime now = DateTime.now();
    return Stack(
      children: <Widget>[
        (isEmpty)
            ? emptyPage
            : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          buildLeavingRequest(list[index]),
                      itemCount: list.length,
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Widget buildLeavingRequest(ListRequest model) {
    Map<int, Widget> mapStatusWidget = {
      0: RoundText(
        title: "Bị từ chối/ Hủy",
        colorText: Colors.white,
        colorBackground: Colors.red,
      ),
      1: RoundText(
        title: "Đã được chấp nhận",
        colorText: Colors.white,
        colorBackground: Colors.green,
      ),
      2: RoundText(
        title: "Đang xử lý",
        colorText: Colors.white,
        colorBackground: Color(0xEEf3ba00),
      ),
    };
    return Card(
        key: Key(model.leavingRequestId) ,
        elevation: 5,
        child: Stack(children: <Widget>[
          Positioned(
            bottom: Random().nextInt(100).toDouble(),
            left: Random().nextInt(100).toDouble() - 40,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: Random().nextInt(100).toDouble() + 40,
              width: Random().nextInt(100).toDouble() + 40,
              margin: EdgeInsets.fromLTRB(8, 0, 8, 12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue.withOpacity(0.4)),
            ),
          ),
          Positioned(
            bottom: Random().nextInt(100).toDouble(),
            left: Random().nextInt(100).toDouble() - 40,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(8, 4, 0, 4),
                  child: CalendarCell(
                    startDate: model.dateFrom,
                    endDate: model.dateTo,
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomExpansionTile(
                      title: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MarqueeWidget(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "${model.leavingRequestId} - ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    mapStatusWidget[model.status]
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Loại :\t",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      maxLines: 100,
                                    ),
                                    Flexible(
                                      child: Text(
                                        model.category,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Ngày tạo :\t",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    MarqueeWidget(
                                      child: Text(
                                        DateFormat("dd/MM/yyyy")
                                            .format(model.submitDate),
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(child: Icon(Icons.expand_more), right: 0,top:0, bottom:0)
                        ],
                      ),
                      children: <Widget>[
                        model.approver.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(4, 0, 0, 4),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                        child: RichText(
                                            text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Người duyệt :\t\t',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: model.approver,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ],
                                    )))
                                  ],
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                  child: RichText(
                                      text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Lý do :\t\t',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: model.reason,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ))),
                            ],
                          ),
                        ),
                        model.response.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(4, 0, 0, 4),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: RichText(
                                          text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Phản hồi :\t\t',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: model.response,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        model.status == 2 ? Center(
                            child: RaisedButton(
                              color: Color(0xEEFF9A00),
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                              onPressed: () {
                                openAlertCancelRequest((){
                                  currentRequestID = model.leavingRequestId;
                                  String date = DateFormat("yyyyMMdd").format(model.submitDate);
                                  store.cancel(model.leavingRequestId.replaceAll("#", ""), date);
                                });

                              },
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(
                                      10.0)),
                              child: Observer(
                                builder: (context){
                                  if(store.isLoadingCancel && model.leavingRequestId.compareTo(currentRequestID)==0)
                                    return SizedBox(width:25,height: 25,child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),));
                                  else
                                    return  Text(
                                      "Hủy đơn",
                                      style: TextStyle(fontSize: 18),
                                    );
                                },
                              ),
                            ))
                       : Container(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ]));
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            child: Stack(
              children: <Widget>[
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
                "Bạn không có đơn xin nghỉ nào trong năm ${store.year}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                textAlign: TextAlign.center,
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
