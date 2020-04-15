import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/data/model/event_detail.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  final int num;

  final Map<DateTime, List<EventDetail>> events;

  final void Function(List<dynamic>,DateTime) onDaySelected;

  final int year;

  MyCalendar({Key key,this.num, this.events, this.onDaySelected, this.year}) : super(key:key);

  @override
  MyCalendarState createState() => MyCalendarState(events, onDaySelected,year);
}

class MyCalendarState extends State<MyCalendar> with TickerProviderStateMixin {
  AnimationController _animationController;

  CalendarController calendarController;

  final Map<DateTime, List<EventDetail>> events;

  final void Function(List<dynamic>,DateTime) onDaySelected;

  final int initialYear;

  MyCalendarState(this.events, this.onDaySelected, this.initialYear);

  bool isEmpty = false;

  int num;

  int currentYear ;
  void changeYear(int year){
    currentYear = year;
    if(currentYear != DateTime.now().year) calendarController.setSelectedDay(DateTime(year));
    else calendarController.setSelectedDay(DateTime.now());
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    calendarController = CalendarController();

    num = widget.num;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animationController.forward();

    currentYear = initialYear;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TableCalendar(
          locale: "en_US",
          rowHeight: 40,
          calendarController: calendarController,
          events: events,
          initialCalendarFormat: CalendarFormat.month,
          formatAnimation: FormatAnimation.slide,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          availableGestures: AvailableGestures.horizontalSwipe,
          availableCalendarFormats: const {
            CalendarFormat.month: '',
          },
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              weekdayStyle:
                  TextStyle().copyWith(color: Colors.white, fontSize: 16)),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle().copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            formatButtonTextStyle:
                TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
            rightChevronIcon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
            leftChevronIcon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 16,
            ),
          ),
          onVisibleDaysChanged: (dateFirst,dateLast,_){
            if(dateLast.isBefore(DateTime(currentYear)))
              {
                calendarController.setSelectedDay(DateTime(currentYear));
              }
            if(dateFirst.isAfter(DateTime(currentYear,12,31)))
              {
                calendarController.setSelectedDay(DateTime(currentYear,12,31));
              }
          },
          builders: CalendarBuilders(
            selectedDayBuilder: (context, date, _) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  '${date.day}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)
                      .copyWith(fontSize: 16.0),
                ),
              );
            },
            dayBuilder: (context, date, _) {
              return Container(
                color: Colors.transparent,
                width: 60,
                height: 60,
                alignment: Alignment.center,
                child: Text(
                  '${date.day}',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle().copyWith(fontSize: 16.0, color: Colors.white),
                ),
              );
            },
            todayDayBuilder: (context, date, events) {
              return Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2)),
                    border: Border.all(color: Colors.black),
                    color: Colors.transparent),
                alignment: Alignment.center,
                child: Text(
                  '${date.day}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ).copyWith(fontSize: 16.0),
                ),
              );
            },
            markersBuilder: (context, date, events, holidays) {
              final children = <Widget>[];

              if (events.isNotEmpty) {
                children.add(
                  Positioned(
                    bottom: 4,
                    child: Center(child: _buildEventsMarker(date, events)),
                  ),
                );
              }
              return children;
            },
          ),
          onDaySelected: (date, events) {
            onDaySelected(events,date);
          },
          initialSelectedDay: initialYear==DateTime.now().year ? DateTime.now() : DateTime(currentYear),


        )
      ],
    );
  }

  Widget _buildEventsMarker(DateTime date, List<EventDetail> events) {
    final children = <Widget>[];
    for (EventDetail detail in events) {
      if (detail.statusRequest == 0) {
        children.add(Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          width: 6.0,
          height: 6.0,
        ));
      } else if (detail.statusRequest == 1) {
        children.add(Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.lightGreenAccent),
          width: 6.0,
          height: 6.0,
        ));
      } else {
        children.add(Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xEEF9AE33)),
          width: 6.0,
          height: 6.0,
        ));
      }
    }
    return Row(
      children: children,
    );
  }

  bool equal(DateTime dateTime1, DateTime dateTime2) {
    if (dateTime1.month == dateTime2.month &&
        dateTime1.year == dateTime2.year &&
        dateTime1.day == dateTime2.day) return true;
    return false;
  }
}
