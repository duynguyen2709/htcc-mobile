import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/event_detail.dart';
import 'package:hethongchamcong_mobile/data/model/shift.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/data/remote/leaving/form_date.dart';
import 'package:hethongchamcong_mobile/screen/leaving/custom_calendar.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_request_screen.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:hethongchamcong_mobile/screen/shift/personal_shift_store.dart';
import 'package:hethongchamcong_mobile/screen/shift/shift_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/custom_expansion_tile.dart';
import 'package:hethongchamcong_mobile/screen/widget/marquee_widget.dart';
import 'package:hethongchamcong_mobile/screen/widget/round_text.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ShiftScreen extends StatefulWidget {

  @override
  _ShiftScreenState createState() =>
      _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  ShiftStore store;
  PersonalShiftStore personalShiftStore;
  int stateOfFooter = 0;

  GlobalKey<MyCalendarState> _calendarKey = GlobalKey();
  Map<DateTime,List<WorkingDayDetail>> workingMap = Map();
  Map<DateTime,List<MiniShiftDetail>> personalShiftMap = Map();
  List<Color> colorList = [
    Colors.red,
    Colors.blue,
  ];

  var offices =[];
  String curOffice = "";
  DateTime selectedDate;

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    store =  ShiftStore();
    personalShiftStore= PersonalShiftStore();
    var formatter = new DateFormat('yyyyMM');
    store.getCompanyWorkingDays(formatter.format(DateTime.now()));
    personalShiftStore.getPersonalShift(formatter.format(DateTime.now()));
    reaction((_) => store.isSuccess, (isSuccess) {
      if (isSuccess == true && mounted ) {
        workingMap.clear();
        offices = store.result.detailMap.keys.toList();
        for(WorkingDayDetail workingDetail in store.result.detailMap[curOffice.isEmpty ? store.result.detailMap.keys.first : curOffice]){
          workingMap[DateTime.parse(workingDetail.date)] = [workingDetail];
        }
        curOffice = curOffice.isEmpty ? store.result.detailMap.keys.first: curOffice;
        setState(() {
        });
      }
      else{
        print("error");
      }
    });

    reaction((_) => personalShiftStore.isSuccess, (isSuccess) {
      if (isSuccess == true && mounted ) {
        personalShiftMap.clear();
        for (ShiftArrangement shiftArrangement in personalShiftStore.result) {
          personalShiftMap[DateTime.parse(shiftArrangement.date)] =
              shiftArrangement.shiftList;
        }
        if (data == null)
          data = personalShiftMap[DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)];
        setState(() {});
      }
      else{
        print("error");
      }
    });

  }
  WorkingDayDetail detail;
  List<MiniShiftDetail> data;


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
      appBar: AppBar(
        title: Text("Lịch làm việc"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          tabs: [
            Tab(
              text: "Công ty",
            ),
            Tab(
              text: "Cá nhân",
            ),
          ],
        ),
      ),
      body :
      TabBarView(
        children: [
          _getCompanyWorkingDayScreen(),
          _getPersonalShift(),
        ],
      ),
    ));
  }

  RefreshIndicator _getCompanyWorkingDayScreen() {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blueAccent,
                        Colors.blue,
                        Colors.lightBlue,
                        Colors.lightBlueAccent,
                      ]),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        store.result!=null ? Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(24, 24, 24, 12),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5))),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: "Chi nhánh",
                                    labelStyle: TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                                    ),
                                  ),
                                  baseStyle: TextStyle(color: Colors.white),
                                  isEmpty: curOffice == '' || curOffice == null,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: curOffice,
                                      isDense: true,
                                      dropdownColor: Colors.blue,
                                      iconDisabledColor: Colors.white,
                                        iconEnabledColor: Colors.white,
                                      onChanged: (newValue) {
                                        setState(() {
                                          curOffice = newValue;
                                        });
                                       filterCompanyWorkingDay();
                                      },
                                      items: store.result.detailMap.keys.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ) :Container()
                      ],
                    ),
                    WorkingDayCalendar(
                      key: _calendarKey,
                      events: workingMap,
                      onDaySelected: (events, date) {
                        if(events.length>0){
                          var temp = events.first as WorkingDayDetail;
                          print(temp.extraInfo);
                           if(temp.extraInfo.isNotEmpty){
                             detail=temp;
                             setState(() {
                             });
                           }
                           else{
                             detail=null;
                             setState(() {
                             });
                           }
                        }
                      },
                      onChangeMonth: (date){
                        store.getCompanyWorkingDays(DateFormat('yyyyMM').format(date));
                      }
                    ),
                    Divider(color: Colors.white,indent: 16, endIndent: 16, thickness: 1.5,),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: new EdgeInsets
                                        .all(5.0),
                                    height: 8.0,
                                    width: 8.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape
                                          .circle,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Nghỉ cả ngày", style: TextStyle(color: Colors.white, fontSize: 18),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: new EdgeInsets
                                        .all(5.0),
                                    height: 8.0,
                                    width: 8.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape
                                          .circle,
                                      color: Colors.lightGreen,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Nghỉ buổi sáng", style: TextStyle(color: Colors.white, fontSize: 18),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: new EdgeInsets
                                            .all(5.0),
                                        height: 8.0,
                                        width: 8.0,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape
                                              .circle,
                                          color: Color(0xEEFF9A00),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Nghỉ buổi chiều", style: TextStyle(color: Colors.white, fontSize: 18),),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: new EdgeInsets
                                            .all(5.0),
                                        height: 8.0,
                                        width: 8.0,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape
                                              .circle,
                                          color: Colors.yellowAccent,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Dịp đặc biệt", style: TextStyle(color: Colors.white, fontSize: 18),),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                        ],
                      )
                    ),
                  ],
                )
              ),
              detail!=null ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                    key: Key(detail.date) ,
                    elevation: 3,
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 30.0,
                                        width: 30.0,
                                        decoration:
                                        new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: new Container(
                                            margin: new EdgeInsets
                                                .all(5.0),
                                            height: 8.0,
                                            width: 8.0,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape
                                                    .circle,
                                                color:Colors.yellow),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${detail.extraInfo}",
                                        textAlign:
                                        TextAlign
                                            .start,
                                        style: TextStyle(
                                            fontSize: 17, fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ])),
              ):Container()
            ],
          ),
        ));
  }

  RefreshIndicator _getPersonalShift() {
    return RefreshIndicator(
        onRefresh: _refresh1,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blueAccent,
                            Colors.blue,
                            Colors.lightBlue,
                            Colors.lightBlueAccent,
                          ]),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShiftCalendar(
                          events: personalShiftMap,
                          onDaySelected: (events, date) {
                            data=events;
                            setState(() {

                            });
                          },
                          onChangeMonth: (date){
                            personalShiftStore.getPersonalShift(DateFormat('yyyyMM').format(date));
                          }
                      ),
                    ],
                  )
              ),
              data==null || data.isEmpty
                  ? emptyPage
                  :
              Column(
                children: data.map((e) => buildShiftItem(e)).toList(),
              )
            ],
          ),
        ));
  }

  Future<void> _refresh() async {
    store.getCompanyWorkingDays(store.curMonth);
  }

  Future<void> _refresh1() async {
    personalShiftStore.getPersonalShift(personalShiftStore.curMonth);
  }

  void filterCompanyWorkingDay() {
    workingMap.clear();
    offices = store.result.detailMap.keys.toList();
    for(WorkingDayDetail workingDetail in store.result.detailMap[curOffice]){
      workingMap[DateTime.parse(workingDetail.date)] = [workingDetail];
    }
    setState(() {
    });
  }

  Widget buildShiftItem(MiniShiftDetail model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
          key: Key(model.shiftId + model.shiftTime) ,
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
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarqueeWidget(
                            child:Row(
                              children: [
                                Text(
                                  model.shiftId + " - ",
                                  textAlign:
                                  TextAlign
                                      .start,
                                  style: TextStyle(
                                      fontSize: 17),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.lightGreen),
                                    borderRadius: BorderRadius
                                        .all(Radius
                                        .circular(
                                        5)),
                                  ),
                                  child: Text(
                                    model.shiftTime,
                                    style: TextStyle(
                                        fontSize:
                                        18,
                                        fontWeight:
                                        FontWeight
                                            .w700),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                model.officeId ,
                                textAlign:
                                TextAlign
                                    .start,
                                style: TextStyle(
                                    fontSize: 17, fontStyle: FontStyle.italic, color: Colors.grey),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }
  
  Widget get emptyPage {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        margin: EdgeInsets.only(top: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/empty_icon.PNG", height: 100,width: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Không có lich làm cho ngày hôm nay.",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
  



}
