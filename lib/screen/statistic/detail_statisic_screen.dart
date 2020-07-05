import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/data/model/statistic.dart';
import 'package:hethongchamcong_mobile/screen/leaving/custom_calendar.dart';
import 'package:hethongchamcong_mobile/screen/widget/photo_viewer.dart';
import 'package:intl/intl.dart';

class DetailStatisticScreen extends StatefulWidget {
  final List<String> date;
  final List<DetailStatisticByDate> listDetail;

  const DetailStatisticScreen({Key key, this.date, this.listDetail}) : super(key: key);

  @override
  _DetailStatisticScreenState createState() => _DetailStatisticScreenState(date, listDetail);
}

class _DetailStatisticScreenState extends State<DetailStatisticScreen> {
  final List<String> date;
  final List<DetailStatisticByDate> listDetail;
  List<DetailCheckInTime> data = [];
  GlobalKey<MyCalendarState> _calendarKey = GlobalKey();
  Map<DateTime, List<DetailCheckInTime>> events = Map();

  _DetailStatisticScreenState(this.date, this.listDetail);

  @override
  void initState() {
    super.initState();
    if (listDetail != null && listDetail.isNotEmpty) {
      for (DetailStatisticByDate dateInfo in listDetail) {
        if (!events.containsKey(DateTime.parse(dateInfo.date))) {
          DateTime date = DateTime.parse(dateInfo.date);
          events[date] = dateInfo.listCheckInTime;
        } else {
          DateTime date = DateTime.parse(dateInfo.date);
          events[date].addAll(dateInfo.listCheckInTime);
        }
      }
      data = listDetail.first.listCheckInTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết'),
          elevation: 0,
        ),
        body: (data.isNotEmpty)
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue, Colors.blue, Colors.lightBlue, Colors.lightBlueAccent]),
                    ),
                    child: WeekCalendar(
                      key: _calendarKey,
                      minDate: DateFormat('dd/MM/yyyy').parse(date.first),
                      maxDate: DateFormat('dd/MM/yyyy').parse(date.last),
                      events: events,
                      onDaySelected: (events, date) {
                        data = events;
                        setState(() {});
                      },
                    ),
                  ),
                  data.isEmpty
                      ? emptyPage
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: ListView.builder(
                              itemBuilder: (context, index) => buildCheckDetailItem(data[index]),
                              itemCount: data.length,
                            ),
                          ),
                        ),
                ],
              )
            : Container(
                height: 2 * MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Không có dữ liệu",
                        style: TextStyle(color: Colors.lightBlue, fontSize: 22, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ));
  }

  Widget buildCheckDetailItem(DetailCheckInTime model) {
    return Card(
        key: Key(model.clientTime.toString()),
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
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.withOpacity(0.4)),
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
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent.withOpacity(0.3)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4),
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
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: new Container(
                                margin: new EdgeInsets.all(5.0),
                                height: 14.0,
                                width: 14.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: model.type == 1 ? Colors.lightGreen : Color(0xEEFF9A00)),
                              ),
                            ),
                          ),
                          Text(
                            "Đã điểm danh ${model.type == 1 ? "vào ca" : "tan ca"} lúc - ",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 17),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: !model.isOnTime
                                      ? Colors.red
                                      : model.type == 1 ? Colors.lightGreen : Color(0xEEFF9A00)),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                              DateFormat("HH:mm").format(DateTime.fromMillisecondsSinceEpoch(model.clientTime)),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(24, 8, 8, 8),
                        child: Text(
                          "${model.shiftName} (${model.shiftTime})",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 15, color: Colors.blueGrey, fontStyle: FontStyle.italic),
                        ),
                      ),
                      model.approver.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(24, 2, 8, 2),
                              child: Text(
                                "Người duyệt: ${model.approver}",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 15, color: Colors.blueGrey, fontStyle: FontStyle.italic),
                              ),
                            )
                          : Container(),
                      model.reason.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(24, 2, 8, 2),
                              child: Text(
                                "Lý do: ${model.reason}",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 15, color: Colors.blueGrey, fontStyle: FontStyle.italic),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                model.image != null
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhotoViewer(
                                        images: [model.image],
                                        initialIndex: 0,
                                      )));
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/human_error.png',
                              image: model.image,
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          )
        ]));
  }

  Widget get emptyPage {
    return Expanded(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/empty_icon.PNG"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Không có lịch sử điểm danh.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
