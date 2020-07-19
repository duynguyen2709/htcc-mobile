import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/statistic.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/statistic/detail_statisic_screen.dart';
import 'package:hethongchamcong_mobile/screen/statistic/statistic_store.dart';
import 'package:hethongchamcong_mobile/utils/MeasureSize.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  List<String> date = [];
  List<BarChartGroupData> data = [];
  String _fromDate =DateFormat('dd/MM/yyyy')
      .format(DateTime(DateTime.now().year,DateTime.now().month,1));
  String _toDate =DateFormat('dd/MM/yyyy')
      .format(DateTime(DateTime.now().year,DateTime.now().month+1,0));
  StatisticStore store;
  User user;
  var heightScreen = Size.zero;

  String formatDateString(String date) {
    DateFormat df = DateFormat('yyyyMMdd');
    return df.format(DateFormat('dd/MM/yyyy').parse(date));
  }

  double milliSecsToHour(int clientTime) {
    var time = DateTime.fromMillisecondsSinceEpoch(clientTime);
    return time.hour.toDouble() + time.minute / 60.toDouble();
  }

  var cardSize = Size.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store = StatisticStore();
    Pref.getInstance().then((pref) {
      user = User.fromJson(json.decode(pref.getString(Constants.USER)));
      store.getStatisticInfo(
          GetStatisticParam(user.companyId, formatDateString(_fromDate), formatDateString(_toDate), user.username));
    });

    reaction((_) => store.isSuccess, (isSuccess) {
      if (isSuccess == true) {
        int x = 0;
        date = [];
        data = [];
        for (var detail in store.result.detailList) {
          bool isComplete = detail.listCheckInTime.length % 2 == 0;
          List<BarChartRodStackItem> barRodsStack = [];
          date.add(DateFormat('dd/MM/yyyy').format(DateTime.parse(detail.date)));
          for (var i = 0; i < detail.listCheckInTime.length; i++) {
            try {
              if (i % 2 == 0) {
                barRodsStack.add(
                  BarChartRodStackItem(
                      milliSecsToHour(detail.listCheckInTime[i].clientTime),
                      (i + 1 < detail.listCheckInTime.length
                          ? detail.listCheckInTime[i + 1].reason.isNotEmpty
                              ? detail.listCheckInTime[i + 1].shiftEndTime
                              : milliSecsToHour(detail.listCheckInTime[i + 1].clientTime)
                          : detail.listCheckInTime[i].shiftEndTime),
                      Colors.lightBlue),
                );
              } else {
                if (i < detail.listCheckInTime.length - 1)
                  barRodsStack.add(
                    BarChartRodStackItem(
                        milliSecsToHour(detail.listCheckInTime[i].clientTime),
                        (i + 1 < detail.listCheckInTime.length
                            ? milliSecsToHour(detail.listCheckInTime[i + 1].clientTime)
                            : detail.listCheckInTime[i].shiftStartTime),
                        Colors.white),
                  );
              }
            } catch (e) {
              print(e);
            }
          }

          if (barRodsStack.isNotEmpty)
            data.add(BarChartGroupData(x: x, barRods: [
              BarChartRodData(
                  y: isComplete
                      ? milliSecsToHour(detail.listCheckInTime[detail.listCheckInTime.length - 1].clientTime)
                      : detail.listCheckInTime[detail.listCheckInTime.length - 1].shiftEndTime,
                  rodStackItem: barRodsStack,
                  borderRadius: const BorderRadius.all(Radius.zero))
            ]));
          else
            data.add(BarChartGroupData(x: x, barRods: [
              BarChartRodData(
                  y: 0,
                  rodStackItem: [
                    BarChartRodStackItem(0, 0, Colors.black),
                  ],
                  borderRadius: const BorderRadius.all(Radius.zero))
            ]));
          x = x + 1;
        }
        setState(() {});
      }
    });
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.blueAccent, Colors.lightBlueAccent],
  ).createShader(Rect.fromLTWH(0.0, 50.0, 200.0, 100.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xEEEEEEEE),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text("Thống kê"),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.blue,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.blueAccent, Colors.blue, Colors.lightBlue, Colors.lightBlueAccent]),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
                  ),
                  MeasureSize(
                    onChange: (size) {
                      heightScreen = size;
                    },
                    child: Column(
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          elevation: 5,
                          child: Wrap(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Từ"),
                                          InkWell(
                                            child: Text(
                                              _fromDate,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()..shader = linearGradient),
                                            ),
                                            onTap: () {
                                              DatePicker.showDatePicker(context,
                                                  showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
                                                setState(() {
                                                  _fromDate = DateFormat('dd/MM/yyyy').format(date);
                                                  store.getStatisticInfo(GetStatisticParam(
                                                      user.companyId,
                                                      formatDateString(_fromDate),
                                                      formatDateString(_toDate),
                                                      user.username));
                                                });
                                              },
                                                  minTime: DateTime.now().subtract(Duration(days: 365)),
                                                  maxTime: DateFormat('dd/MM/yyyy').parse(_toDate),
                                                  currentTime: DateFormat('dd/MM/yyyy').parse(_fromDate),
                                                  locale: LocaleType.vi);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: VerticalDivider(
                                        thickness: 1,
                                        indent: 5,
                                        endIndent: 5,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Đến"),
                                          InkWell(
                                            child: Text(
                                              _toDate,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()..shader = linearGradient),
                                            ),
                                            onTap: () {
                                              DatePicker.showDatePicker(context,
                                                  showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
                                                setState(() {
                                                  _toDate = DateFormat('dd/MM/yyyy').format(date);
                                                  store.getStatisticInfo(GetStatisticParam(
                                                      user.companyId,
                                                      formatDateString(_fromDate),
                                                      formatDateString(_toDate),
                                                      user.username));
                                                });
                                              },
                                                  currentTime: DateFormat('dd/MM/yyyy').parse(_toDate),
                                                  minTime: DateFormat('dd/MM/yyyy').parse(_fromDate),
                                                  maxTime: DateTime.now(),
                                                  locale: LocaleType.vi);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 2.15,
                              child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 10,
                                                width: 10,
                                                margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                                decoration:
                                                    BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
                                              ),
                                              Text(
                                                "Có mặt",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.fromLTRB(16, 4, 0, 4),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 10,
                                                width: 10,
                                                margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle, color: Colors.grey.withAlpha(50)),
                                              ),
                                              Text(
                                                "Vắng",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.fromLTRB(16, 4, 0, 4),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: CircularPercentIndicator(
                                            radius: 110,
                                            lineWidth: 10.0,
                                            animation: true,
                                            percent: (store.result == null ||
                                                    (DateFormat('dd/MM/yyyy')
                                                                .parse(_toDate)
                                                                .difference(DateFormat('dd/MM/yyyy').parse(_fromDate)))
                                                            .inHours >
                                                        24)
                                                ? 0
                                                : store.result.workingDays /
                                                    (DateFormat('dd/MM/yyyy')
                                                            .parse(_toDate)
                                                            .difference(DateFormat('dd/MM/yyyy').parse(_fromDate)))
                                                        .inDays,
                                            center: Container(
                                              margin: EdgeInsets.only(left: 9),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Text(
                                                    (store.result == null ||
                                                            (DateFormat('dd/MM/yyyy').parse(_toDate).difference(
                                                                        DateFormat('dd/MM/yyyy').parse(_fromDate)))
                                                                    .inHours >
                                                                24)
                                                        ? '0'
                                                        : ((store.result.workingDays /
                                                                    (DateFormat('dd/MM/yyyy').parse(_toDate).difference(
                                                                            DateFormat('dd/MM/yyyy').parse(_fromDate)))
                                                                        .inDays) *
                                                                100)
                                                            .toStringAsFixed(0),
                                                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
                                                  ),
                                                  Text("%", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                                                ],
                                              ),
                                            ),
                                            circularStrokeCap: CircularStrokeCap.round,
                                            progressColor: Colors.blueAccent,
                                            backgroundColor: Colors.grey.withAlpha(50),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width / 2.15,
                              child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 8,
                                                width: 8,
                                                margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                decoration:
                                                    BoxDecoration(shape: BoxShape.circle, color: Colors.lightBlue),
                                              ),
                                              Text(
                                                "Đúng giờ",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.fromLTRB(16, 4, 0, 4),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 8,
                                                width: 8,
                                                margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle, color: Colors.grey.withAlpha(50)),
                                              ),
                                              Text(
                                                "Đến sớm / trễ",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.fromLTRB(16, 4, 0, 4),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: CircularPercentIndicator(
                                            radius: 110,
                                            lineWidth: 10.0,
                                            animation: true,
                                            percent: store.result == null
                                                ? 0
                                                : store.result.onTimePercentage.toDouble() / 100,
                                            center: Container(
                                              margin: EdgeInsets.only(left: 9),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Text(
                                                    store.result == null
                                                        ? '0.0'
                                                        : store.result.onTimePercentage.toStringAsFixed(0),
                                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                                  ),
                                                  Text("%", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                                                ],
                                              ),
                                            ),
                                            circularStrokeCap: CircularStrokeCap.round,
                                            progressColor: Colors.lightBlue,
                                            backgroundColor: Colors.grey.withAlpha(50),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MeasureSize(
                              onChange: (size) {
                                cardSize = size;
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width / 2.15,
                                child: Card(
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Số giờ làm việc ngoài giờ",
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                          Container(
                                            height: 20,
                                          ),
                                          Text(
                                            store.result == null ? '0.0' : store.result.overtimeHours.toString(),
                                            style: TextStyle(fontSize: 40, color: Colors.lightBlueAccent),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailStatisticScreen(
                                            date: date,
                                            listDetail: store.result?.detailList ?? [],
                                          )),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width / 2.15,
                                height: cardSize.height,
                                child: Card(
                                    elevation: 5,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 40),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.blue,
                                            size: 40,
                                          ),
                                          Container(
                                            height: 10,
                                          ),
                                          Text(
                                            "CHI TIẾT",
                                            style: TextStyle(
                                                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Wrap(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            store.result == null ? '0.0' : store.result.totalDays.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                          ),
                                          Text(
                                            "Tổng",
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: VerticalDivider(
                                        thickness: 1,
                                        indent: 5,
                                        endIndent: 5,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            store.result == null ? '0.0' : store.result.workingDays.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue),
                                          ),
                                          Text(
                                            "Ngày làm",
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: VerticalDivider(
                                        thickness: 1,
                                        indent: 5,
                                        endIndent: 5,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            store.result == null ? '0.0' : store.result.nonPermissionOffDays.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xEEf3ba00)),
                                          ),
                                          Text(
                                            "Ngày nghỉ",
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.only(left: 16, right: 12),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: EdgeInsets.only(left: 12, top: 24, right: 12, bottom: 8),
                              width: MediaQuery.of(context).size.width,
                              child: BarChart(
                                BarChartData(
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 24,
                                    gridData: FlGridData(
                                      show: true,
                                      checkToShowVerticalLine: (value) => value == 0,
                                      getDrawingVerticalLine: (value) => FlLine(
                                        color: Colors.grey,
                                        strokeWidth: 1,
                                      ),
                                      checkToShowHorizontalLine: (value) => value == 8 || value == 17,
                                      getDrawingHorizontalLine: (value) =>
                                          FlLine(color: Colors.grey, strokeWidth: 1, dashArray: [8, 2]),
                                    ),
                                    barTouchData: BarTouchData(
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: Colors.grey,
                                        getTooltipItem: (_a, _b, _c, _d) => null,
                                      ),
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        textStyle:
                                            TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
                                        margin: 18,
                                        getTitles: (double value) {
                                          if (date.length <= 7)
                                            return date[value.toInt()].substring(0, 5);
                                          else {
                                            var step = (date.length / 7).ceil();
                                            if (value % step == 0)
                                              return date[value.floor()].substring(0, 5);
                                            else
                                              return '';
                                          }
                                        },
                                      ),
                                      leftTitles: SideTitles(
                                          showTitles: true,
                                          textStyle:
                                              TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
                                          margin: 16,
                                          getTitles: (double value) {
                                            switch (value.toInt()) {
                                              case 0:
                                                return '12 am';
                                              case 4:
                                                return '4 am';
                                              case 8:
                                                return '8 am';
                                              case 12:
                                                return '12 pm';
                                              case 16:
                                                return '4 pm';
                                              case 20:
                                                return '8 pm';
                                              case 24:
                                                return '12 am';
                                              default:
                                                return '';
                                            }
                                          }),
                                    ),
                                    borderData: FlBorderData(
                                        show: true,
                                        border: Border(
                                            left: BorderSide(color: Colors.grey),
                                            bottom: BorderSide(color: Colors.grey),
                                            top: BorderSide.none,
                                            right: BorderSide.none)),
                                    barGroups: data),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                        )
                      ],
                    ),
                  ),
                  Observer(builder: (_) {
                    if (store.isLoading)
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height < heightScreen.height
                            ? heightScreen.height
                            : MediaQuery.of(context).size.height,
                        color: Colors.black45,
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      );
                    else
                      return Center();
                  }),
                ],
              ),
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
