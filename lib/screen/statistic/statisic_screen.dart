import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final date = [
    "12/2",
    "13/2",
    "14/2",
    "15/2",
    "16/2",
    "17/2",
    "18/2",
    "19/2",
    "20/2",
    "21/2",
    "22/2",
    "23/2",
    "24/2",
    "25/2",
    "26/2",
    "27/2",
    "28/2",
    "29/2"
  ];
  List<BarChartGroupData> data = [];
  String _fromDate ="12/02/2020";
  String _toDate ="29/02/2020";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fake data
    data = [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(
            y: 17,
            rodStackItem: [
              BarChartRodStackItem(8, 17, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(
            y: 22,
            rodStackItem: [
              BarChartRodStackItem(7.5, 22, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(
            y: 18,
            rodStackItem: [
              BarChartRodStackItem(9, 18, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(
            y: 18,
            rodStackItem: [
              BarChartRodStackItem(7.5, 18, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 4, barRods: [
        BarChartRodData(
            y: 18,
            rodStackItem: [
              BarChartRodStackItem(9, 18, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 5, barRods: [
        BarChartRodData(
            y: 17,
            rodStackItem: [
              BarChartRodStackItem(8, 17, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 6, barRods: [
        BarChartRodData(
            y: 20,
            rodStackItem: [
              BarChartRodStackItem(9, 20, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 7, barRods: [
        BarChartRodData(
            y: 18,
            rodStackItem: [
              BarChartRodStackItem(7.5, 18, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 8, barRods: [
        BarChartRodData(
            y: 20,
            rodStackItem: [
              BarChartRodStackItem(9, 20, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 9, barRods: [
        BarChartRodData(
            y: 17,
            rodStackItem: [
              BarChartRodStackItem(7.5, 18, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 10, barRods: [
        BarChartRodData(
            y: 18,
            rodStackItem: [
              BarChartRodStackItem(8, 17, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 11, barRods: [
        BarChartRodData(
            y: 18,
            rodStackItem: [
              BarChartRodStackItem(7.5, 18, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 12, barRods: [
        BarChartRodData(
            y: 18,
            rodStackItem: [
              BarChartRodStackItem(9, 18, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 13, barRods: [
        BarChartRodData(
            y: 20,
            rodStackItem: [
              BarChartRodStackItem(9, 20, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 14, barRods: [
        BarChartRodData(
            y: 20,
            rodStackItem: [
              BarChartRodStackItem(9, 20, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 15, barRods: [
        BarChartRodData(
            y: 17,
            rodStackItem: [
              BarChartRodStackItem(8, 17, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 16, barRods: [
        BarChartRodData(
            y: 18,
            rodStackItem: [
              BarChartRodStackItem(7.5, 18, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
      BarChartGroupData(x: 17, barRods: [
        BarChartRodData(
            y: 18,
            rodStackItem: [
              BarChartRodStackItem(7.5, 18, Colors.lightBlue),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
      ]),
    ];
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.blueAccent, Colors.lightBlueAccent],
  ).createShader(Rect.fromLTWH(0.0, 50.0, 200.0, 100.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xEEEEEEEE),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              //Wave header
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blueAccent,
                        Colors.blue,
                        Colors.lightBlue,
                        Colors.lightBlueAccent
                      ]),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
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
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            foreground: Paint()
                                              ..shader = linearGradient),
                                      ),
                                      onTap: (){
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            onChanged: (date) {},
                                            onConfirm: (date) {
                                              setState(() {
                                                _fromDate = DateFormat('dd/MM/yyyy')
                                                    .format(date);
                                              });
                                            },
                                            minTime: DateTime.now().subtract(Duration(days: 365)),
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.vi);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container( height: 50,child: VerticalDivider(
                                thickness: 1,
                                indent: 5,
                                endIndent: 5,
                              ),),

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
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            foreground: Paint()
                                              ..shader = linearGradient),
                                      ),
                                      onTap: (){
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            onChanged: (date) {},
                                            onConfirm: (date) {
                                              setState(() {
                                                 _toDate = DateFormat('dd/MM/yyyy')
                                                     .format(date);
                                              });
                                            },
                                            currentTime: DateTime.now(),
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
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  SizedBox(
                    height: 230,
                    child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            width: 200,
                            child: Card(
                                elevation: 5,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10,
                                            width: 10,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 16, 0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blueAccent),
                                          ),
                                          Text(
                                            "Có mặt",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.fromLTRB(16, 4, 0, 4),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10,
                                            width: 10,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 16, 0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey
                                                    .withAlpha(50)),
                                          ),
                                          Text(
                                            "Vắng",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.fromLTRB(16, 4, 0, 4),
                                    ),
                                    CircularPercentIndicator(
                                      radius: 140,
                                      lineWidth: 12.0,
                                      animation: true,
                                      percent: 0.8,
                                      center: Container(
                                        margin: EdgeInsets.only(left: 9),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              "80",
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight:
                                                      FontWeight.w600),
                                            ),
                                            Text("%",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ],
                                        ),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.blueAccent,
                                      backgroundColor:
                                          Colors.grey.withAlpha(50),
                                    ),
                                  ],
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: 200,
                            child: Card(
                                elevation: 5,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10,
                                            width: 10,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 16, 0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blueAccent),
                                          ),
                                          Text(
                                            "Đúng giờ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.fromLTRB(16, 4, 0, 4),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10,
                                            width: 10,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 16, 0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey
                                                    .withAlpha(50)),
                                          ),
                                          Text(
                                            "Đến sớm /trễ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.fromLTRB(16, 4, 0, 4),
                                    ),
                                    CircularPercentIndicator(
                                      radius: 140,
                                      lineWidth: 12.0,
                                      animation: true,
                                      percent: 0.78,
                                      center: Container(
                                        margin: EdgeInsets.only(left: 9),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              "78",
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight:
                                                      FontWeight.w600),
                                            ),
                                            Text("%",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ],
                                        ),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.lightBlue,
                                      backgroundColor:
                                          Colors.grey.withAlpha(50),
                                    ),
                                  ],
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            height:
                                230,
                            width: 200,
                            child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Số giờ làm việc ngoài giờ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        height: 20,
                                      ),
                                      Text(
                                        "40.0",
                                        style: TextStyle(
                                            fontSize: 60,
                                            color: Colors.lightBlueAccent),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ]),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(16),
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
                                      "11",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    Text(
                                      "Tổng",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container( height: 50,child: VerticalDivider(
                                thickness: 1,
                                indent: 5,
                                endIndent: 5,
                              ),),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "11",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Colors.blue),
                                    ),
                                    Text(
                                      "Ngày làm",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Container( height: 50,child: VerticalDivider(
                                thickness: 1,
                                indent: 5,
                                endIndent: 5,
                              ),),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Color(0xEEf3ba00)),
                                    ),
                                    Text(
                                      "Ngày nghỉ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
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
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 12,
                              spreadRadius: 5)
                        ]),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.only(
                        left: 10, top: 8, right: 12, bottom: 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 16, top: 24, right: 12, bottom: 12),
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
                                checkToShowHorizontalLine: (value) =>
                                    value == 8 || value == 17,
                                getDrawingHorizontalLine: (value) => FlLine(
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                    dashArray: [8, 2]),
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
                                  textStyle: TextStyle(
                                      color: const Color(0xff7589a2),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  margin: 20,
                                  getTitles: (double value) {
                                    if (date.length <= 7)
                                      return date[value.toInt()];
                                    else {
                                      var step = (date.length / 7.0).ceil();
                                      if (value % step == 0)
                                        return date[value.floor()];
                                      else
                                        return '';
                                    }
                                  },
                                ),
                                leftTitles: SideTitles(
                                    showTitles: true,
                                    textStyle: TextStyle(
                                        color: const Color(0xff7589a2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    margin: 20,
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
              )
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
