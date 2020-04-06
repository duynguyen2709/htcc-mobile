import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/complaint.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/complaint/complaint_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintForm extends StatefulWidget {
  final ComplaintStore store;

  const ComplaintForm({Key key, this.store}) : super(key: key);
  @override
  _ComplaintFormState createState() => _ComplaintFormState(store);
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _imageKey1 = new GlobalKey<PickImageWidgetState>();
  final _imageKey2 = new GlobalKey<PickImageWidgetState>();
  final _imageKey3 = new GlobalKey<PickImageWidgetState>();
  TextEditingController _controller = new TextEditingController();
  final ComplaintStore store;
  bool isAnonymously = false;
  int _value = 1;
  String name = "";
  var _options = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  var _sendTo = ["Hệ thống", "Công ty"];
  String _currentSelectedValue = 'Hệ thống';
  var _opacity = 1.0;
  var _alignment = Alignment.center;
  var _isBack = false;
  var _timer;

  _ComplaintFormState(this.store);

  _onSwitchChange(bool newVal) {
    setState(() {
      isAnonymously = newVal;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      User user = User.fromJson(json.decode(pref.getString(Constants.USER)));
      setState(() {
        name = user.fullName;
      });
    });
    reaction((_) => store.postComplaintSuccess, (isSuccess) async {
      if (isSuccess == true) {
        _showMessage("Gửi góp ý/ khiếu nại thành công.");
      } else if (isSuccess != null){
        _showErrorDialog(store.errorAuth);
      }
    });
  }
  void _showMessage(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Constants.titleErrorDialog),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(Constants.buttonErrorDialog),
              onPressed: () {
                Navigator.of(context).pop('Success');
                if(store.postComplaintSuccess)  Navigator.pop(context,'Success');
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(bool isAuthErr) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Constants.titleErrorDialog),
          content: new Text(store.errorMsg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(Constants.buttonErrorDialog),
              onPressed: () {
                Navigator.of(context).pop();
                if (isAuthErr)
                  Navigator.pushReplacementNamed(
                      context, Constants.login_screen);
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
    return Scaffold(
      resizeToAvoidBottomPadding:false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Góp Ý - Khiếu Nại"),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: Text(
                              "Họ tên",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 12),
                          child: TextFormField(
                            enabled: false,
                            initialValue: name,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide:
                                        BorderSide(color: Color(0xff00b0e3))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(color: Colors.grey)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(color: Colors.grey)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 22),
                                hintText: name),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Switch(
                              value: isAnonymously,
                              onChanged: (val) => _onSwitchChange(val),
                            ),
                            Text("Chế độ ẩn danh")
                          ],
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 4),
                            child: Text(
                              "Gửi đến",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            )),
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              isEmpty: _currentSelectedValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentSelectedValue == ''
                                      ? null
                                      : _currentSelectedValue,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _currentSelectedValue = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: _sendTo.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 4),
                            child: Text(
                              "Chủ đề",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            )),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 8.0,
                          children: List<Widget>.generate(
                            _options.length,
                            (int index) {
                              return AnimatedContainer(
                                duration: Duration(seconds: 1),
                                child: ChoiceChip(
                                  pressElevation: 3,
                                  selectedColor: Colors.blue,
                                  backgroundColor: Colors.grey.withAlpha(20),
                                  label: !(_value == index)
                                      ? Padding(
                                          child: Text(_options[index]),
                                          padding: EdgeInsets.all(8),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Wrap(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        4, 0, 4, 0),
                                                child: Text(
                                                  _options[index],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )),
                                  selected: _value == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _value = selected ? index : null;
                                    });
                                  },
                                ),
                              );
                            },
                          ).toList(),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: Text(
                              "Nội dung",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            )),
                        TextField(
                          minLines: 8,
                          maxLines: 50,
                          textAlign: TextAlign.left,
                          controller: _controller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(color: Color(0xff00b0e3))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(color: Colors.grey)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PickImageWidget(
                              key: _imageKey1,
                            ),
                            PickImageWidget(
                              key: _imageKey2,
                            ),
                            PickImageWidget(
                              key: _imageKey3,
                            )
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top:8, left: 12),
                          child: Text("* Tối đa 10Mb/ hình",style: TextStyle(color: Colors.red, fontSize: 12),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(height: 80,)
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
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
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      padding: EdgeInsets.only(left: 6),
                      alignment: Alignment.center,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () async {
                          if(_controller.text.isNotEmpty) {
                            if (_timer != null) _timer.cancel();
                            _timer =
                            new Timer(const Duration(seconds: 5), () {
                              if(mounted){setState(() {
                                _isBack = true;
                                _alignment = Alignment.center;
                                _opacity = 1.0;
                              });
                              }});
                            if(mounted)
                              setState(() {
                                _isBack = false;
                                _alignment = _alignment == Alignment.bottomRight
                                    ? Alignment.center
                                    : Alignment.bottomRight;
                                _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                              });
                            var image1 = await _getMultipartFile(
                                _imageKey1.currentState.pickedImage);
                            var image2 = await _getMultipartFile(
                                _imageKey2.currentState.pickedImage);
                            var image3 = await _getMultipartFile(
                                _imageKey3.currentState.pickedImage);
                            List<MultipartFile> images = List();
                            if (image1 != null) images.add(image1);
                            if (image2 != null) images.add(image2);
                            if (image3 != null) images.add(image3);
                            SharedPreferences.getInstance().then((pref) {
                              String jsonUser = pref.getString(
                                  Constants.USER);
                              if (jsonUser != null && jsonUser.isNotEmpty) {
                                User user = User.fromJson(
                                    json.decode(jsonUser));
                                CreateComplaintParam param = CreateComplaintParam(
                                    companyId: user.companyId,
                                    username: user.username,
                                    clientTime: DateTime
                                        .now()
                                        .millisecondsSinceEpoch,
                                    images: [image1, image2, image3],
                                    complaint: Complaint(
                                        category: _options[_value],
                                        content: _controller.text,
                                        receiverType: _sendTo.indexOf(
                                            _currentSelectedValue) + 1,
                                        isAnonymous: isAnonymously ? 1 : 0));
                                store.postComplaint(param);
                              }
                            });
                          }
                          else{
                            _showMessage("Nội dung góp ý/ khiếu nại không được để trống.");
                          }

                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Observer(builder: (_) {
              if (store.isLoading)
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height:  MediaQuery.of(context).size.height * 1.5 ,
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
        ),
      ),
    );
  }

  Future<MultipartFile> _getMultipartFile(File file) async {
    if(file!=null) {
      String fileName = file.path.split('/').last;
      var res = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );
      return res;
    }
    else return null;
  }
}
