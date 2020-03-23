import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/screen/widget/image_picker.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  FocusNode focusNodeTitle = new FocusNode();
  FocusNode focusNodeName = new FocusNode();
  bool isAnonymously = false;
  int _value = 1;
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
  String _currentSelectedValue = '';
  var _opacity = 1.0;
  var _alignment = Alignment.center;
  var _isBack = false;
  var _timer;

  _onSwitchChange(bool newVal) {
    setState(() {
      isAnonymously = newVal;
      focusNodeName.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Góp Ý - Khiếu Nại"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Container(alignment: Alignment.centerLeft,padding: EdgeInsets.fromLTRB(0, 0, 0, 16),child: Text("Họ tên", style: TextStyle(fontSize: 16,color: Colors.grey),)),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 12),
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Color(0xff00b0e3))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey)),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                          ),
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
                      Container(alignment: Alignment.centerLeft,padding: EdgeInsets.fromLTRB(0, 16, 0, 4),child: Text("Chủ đề", style: TextStyle(fontSize: 16,color: Colors.grey),)),

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
                                label: !(_value == index) ? Padding(child: Text(_options[index]), padding: EdgeInsets.all(8),) : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.check,color: Colors.white,size: 20,),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Text(_options[index], style: TextStyle(color: Colors.white),),
                                      ),
                                    ],
                                  )
                                ),
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
                      Container(alignment: Alignment.centerLeft,padding: EdgeInsets.fromLTRB(0, 0, 0, 16),child: Text("Nội dung", style: TextStyle(fontSize: 16,color: Colors.grey),)),
                      TextField(
                        minLines: 5,
                        maxLines: 50,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Color(0xff00b0e3))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          PickImageWidget(),
                          PickImageWidget(),
                          PickImageWidget()
                        ],
                      ),
                    ],
                  ),
                ),
                Container(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
                  ),
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
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                        padding: EdgeInsets.only(left: 6),
                        alignment: Alignment.center,
                        child: InkWell(
                          splashColor: Colors.grey,
                          onTap: () {
                            if (_timer != null) _timer.cancel();
                            _timer =
                                new Timer(const Duration(seconds: 5), () {
                              setState(() {
                                _isBack = true;
                                _alignment = Alignment.center;
                                _opacity = 1.0;
                              });
                            });
                            setState(() {
                              _isBack = false;
                              _alignment = _alignment == Alignment.bottomRight
                                  ? Alignment.center
                                  : Alignment.bottomRight;
                              _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                            });
                          },
                          child:  Icon(
                            Icons.send,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
