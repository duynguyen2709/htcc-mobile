import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/complaint.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/complaint/complaint_detail/complaint_detail_store.dart';
import 'package:hethongchamcong_mobile/screen/dialog/app_dialog.dart';
import 'package:hethongchamcong_mobile/screen/widget/info_line.dart';
import 'package:hethongchamcong_mobile/screen/widget/photo_viewer.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintDetail extends StatefulWidget {
  final Complaint complaint;

  const ComplaintDetail({Key key, this.complaint}) : super(key: key);

  @override
  _ComplaintDetailState createState() => _ComplaintDetailState();
}

class _ComplaintDetailState extends State<ComplaintDetail> {
  Complaint complaint;

  ComplaintDetailStore store;

  TextEditingController _controller = new TextEditingController();

  var _opacity = 1.0;
  var _alignment = Alignment.center;
  var _isBack = false;
  var _timer;

  @override
  void initState() {
    super.initState();
    complaint = widget.complaint;
    store = ComplaintDetailStore();
    reaction((_) => store.postComplaintSuccess, (isSuccess) async {
      if (isSuccess == true) {
        AppDialog.showDialogNotify(context, "Gửi góp ý/ khiếu nại thành công.", (){
          Navigator.pop(context, 'Success');
        });
      } else if (isSuccess != null) {
        AppDialog.showDialogNotify(context, store.errorMsg, (){
          if (store.errorAuth) Navigator.pushReplacementNamed(context, Constants.login_screen);
        });
      }
    });
  }

  String codeToStatus(int code) {
    switch (code) {
      case 1:
        return 'Đã xử lý';
      case 2:
        return 'Đang xử lý';
      case 3:
        return 'Bị từ chối xử lý';
      default:
        return 'Đang xử lý';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nội dung"),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.blue,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                        child: Wrap(
                      children: <Widget>[
                        Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                          InfoLine(
                            title: "ID",
                            content: this.complaint.complaintId,
                            textStyle: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          InfoLine(title: "Chủ đề", content: this.complaint.category),
                          InfoLine(title: "Ngày gửi", content: this.complaint.date + " " + this.complaint.time),
                          InfoLine(
                              title: "Người nhận", content: this.complaint.receiverType == 1 ? "Hệ thống" : "Công ty"),
                          InfoLine(
                              title: "Trạng thái",
                              content: codeToStatus(this.complaint.status),
                              textStyle: TextStyle(fontStyle: FontStyle.italic)),
                        ]),
                      ],
                    )),
                    Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Text(
                                    "Ảnh đính kèm",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          complaint.images.length > 0
                              ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: complaint.images.map((element) {
                                return Card(
                                  margin: EdgeInsets.all(15),
                                  elevation: 10,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PhotoViewer(
                                                images: complaint.images,
                                                initialIndex: complaint.images.indexOf(element),
                                              )));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(4),
                                      child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/gif/loading.gif',
                                          image: element,
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context).size.width / 3.5,
                                          height: MediaQuery.of(context).size.width / 3.5),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: getAvatar(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return ChatFormCard(
                            title: "Nội dung",
                            content: this.complaint.content,
                            response: this.complaint.response,
                            avatar: snapshot.data,
                          );
                        } else
                          return Center();
                      },
                    ),
                    (complaint.status != 2)
                        ? Card(
                            child: Container(
                              height: 100,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: TextField(
                                  minLines: 8,
                                  maxLines: 50,
                                  textAlign: TextAlign.left,
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: "Phản hồi/ khiếu nại thêm ...",
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Color(0xff00b0e3))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderSide: BorderSide(color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
            (complaint.status != 2)
                ? Positioned(
                    bottom: -4,
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          AnimatedContainer(
                            duration: Duration(seconds: _isBack ? 0 : 4),
                            alignment: _alignment,
                            child: AnimatedOpacity(
                              opacity: _opacity,
                              duration: Duration(seconds: _isBack ? 0 : 3),
                              child: Icon(
                                Icons.send,
                                color: Colors.blue,
                                size: 35,
                              ),
                            ),
                          ),
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                            padding: EdgeInsets.only(left: 6),
                            alignment: Alignment.center,
                            child: InkWell(
                              splashColor: Colors.grey,
                              onTap: () async {
                                if (_controller.text.isNotEmpty) {
                                  if (_timer != null) _timer.cancel();
                                  _timer = new Timer(const Duration(seconds: 5), () {
                                    if (mounted) {
                                      setState(() {
                                        _isBack = true;
                                        _alignment = Alignment.center;
                                        _opacity = 1.0;
                                      });
                                    }
                                  });
                                  if (mounted)
                                    setState(() {
                                      _isBack = false;
                                      _alignment = _alignment == Alignment.bottomRight
                                          ? Alignment.center
                                          : Alignment.bottomRight;
                                      _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                                    });
                                  RePostComplaintParam rePostComplaintParam = RePostComplaintParam(
                                      complaintId: complaint.complaintId,
                                      content: _controller.text,
                                      date: DateFormat("yyyyMM").format(DateTime.now()));
                                  store.rePostComplaint(rePostComplaintParam);
                                } else {
                                  AppDialog.showDialogNotify(context, "Nội dung góp ý/ khiếu nại không được để trống.", (){});
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            Observer(builder: (_) {
              if (store.isLoading)
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1.5,
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
        ));
  }

  Future<String> getAvatar() async {
    var sharedPreference = await SharedPreferences.getInstance();
    User account = User.fromJson(json.decode(sharedPreference.getString(Constants.USER)));
    return account.avatar;
  }
}
