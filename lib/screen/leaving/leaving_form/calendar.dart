import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';

import 'leaving_form_store.dart';

class Calendar extends StatefulWidget {
  final LeavingFormStore leavingFormStore;

  final int num;

  Calendar({this.leavingFormStore, this.num});

  @override
  _CalendarState createState() => _CalendarState(leavingFormStore: leavingFormStore);
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  final LeavingFormStore leavingFormStore;

  AnimationController _animationController;

  CalendarController _calendarController;

  _CalendarState({this.leavingFormStore});

  bool isEmpty = false;

  int num;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    num = widget.num;

    leavingFormStore.init();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    reaction((_) => leavingFormStore.isBooking, (isBooking) {
      if (isBooking == false) leavingFormStore.listBooking.clear();
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: "en_US",
      rowHeight: 40,
      calendarController: _calendarController,
      events: leavingFormStore.events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.horizontalSwipe,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.red),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          if (!leavingFormStore.listBooking.contains(date) || isEmpty) {
            if (equal(date, DateTime.now())) {
              //(Bold,accent)
              return Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  '${date.day}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold).copyWith(fontSize: 16.0),
                ),
              );
            }
            if (date.compareTo(DateTime.now()) < 0)
              //(Bold)
              return Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  '${date.day}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w300).copyWith(fontSize: 16.0),
                ),
              );
            return Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                '${date.day}',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold).copyWith(fontSize: 16.0),
              ),
            );
          }
          if (equal(DateTime.now(), date) == true)
            //(Bold),green
            return SelectedDay(
              day: date.day,
            );
          if (date.compareTo(DateTime.now()) > 0) {
            //green
            return SelectedDay(
              day: date.day,
            );
          } else {
            //(w300), transparent
            return Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '${date.day}',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300).copyWith(fontSize: 16.0),
              ),
            );
          }
        },
        dayBuilder: (context, date, _) {
          if (leavingFormStore.isBooking == false) {
            return Container(
              color: Colors.transparent,
              width: 60,
              height: 60,
              alignment: Alignment.center,
              child: Text(
                '${date.day}',
                textAlign: TextAlign.center,
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            );
          } else {
            int compare = date.compareTo(DateTime.now());
            bool flag = false;
            if (leavingFormStore.listBooking != null)
              leavingFormStore.listBooking.forEach((value) {
                if (equal(date, value)) {
                  flag = true;
                  return;
                }
              });
            if (flag == true) {
              return SelectedDay(
                day: date.day,
              );
            } else {
              if (compare < 0)
                return Container(
                  color: Colors.transparent,
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    '${date.day}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w300).copyWith(fontSize: 16.0),
                  ),
                );
              else {
                return Container(
                  color: Colors.transparent,
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    '${date.day}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold).copyWith(fontSize: 16.0),
                  ),
                );
              }
            }
          }
        },
        todayDayBuilder: (context, date, _) {
          if (leavingFormStore.listBooking.contains(date) && leavingFormStore.isBooking == true)
            return SelectedDay(
              day: date.day,
            );
          else
            return Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text(
                '${date.day}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ).copyWith(fontSize: 16.0),
              ),
            );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Center(
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          return children;
        },
      ),
      onDaySelected: (date, events) {
        if (leavingFormStore.isBooking) {
          if (date.compareTo(DateTime.now()) > 0 || equal(date, DateTime.now())) if (!events.contains(date)) {
            if (leavingFormStore.listBooking.contains(date)) {
              leavingFormStore.listBooking.remove(date);
              if (leavingFormStore.listBooking.length == 0) {
                isEmpty = true;
                _calendarController.setSelectedDay(DateTime.now());
              } else {
                _calendarController.setSelectedDay(leavingFormStore.listBooking.last);
              }
            } else {
              if (leavingFormStore.listBooking.length < num && checkInEventList(date))
                leavingFormStore.listBooking.add(date);
              isEmpty = false;
              leavingFormStore.listBooking.sort();
            }
          }
        }
      },
    );
  }

  bool checkInEventList(DateTime dateTime) {
    bool flag = true;
    leavingFormStore.events.keys.forEach((value) {
      if (equal(value, dateTime)) {
        flag = false;
      }
    });

    return flag;
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red.withOpacity(0.5)),
      child: Center(),
    );
  }

  bool equal(DateTime dateTime1, DateTime dateTime2) {
    if (dateTime1.month == dateTime2.month && dateTime1.year == dateTime2.year && dateTime1.day == dateTime2.day)
      return true;
    return false;
  }
}

class SelectedDay extends StatelessWidget {
  final int day;

  const SelectedDay({Key key, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
//                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.lightBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3, // has the effect of softening the shadow
            spreadRadius: 3, // has the effect of extending the shadow
            offset: Offset(
              0, // horizontal, move right 10
              0, // vertical, move down 10
            ),
          )
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        '$day',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white).copyWith(fontSize: 16.0),
      ),
    );
  }
}

class DisableDay extends StatelessWidget {
  final int day;

  const DisableDay({Key key, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3, // has the effect of softening the shadow
            spreadRadius: 3, // has the effect of extending the shadow
            offset: Offset(
              0, // horizontal, move right 10
              0, // vertical, move down 10
            ),
          )
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        '$day',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white).copyWith(fontSize: 16.0),
      ),
    );
  }
}
