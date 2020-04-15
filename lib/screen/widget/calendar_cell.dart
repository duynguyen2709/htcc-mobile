import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarCell extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  int difference = 0;

  CalendarCell({this.startDate, this.endDate}) {
    difference = endDate.difference(startDate).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 72,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Color(0xEED5D5D5),
                offset: Offset(2.0, 2.0), //(x,y)
                blurRadius: 5.0,
              ),
            ]),
        child: difference > 1
            ? Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(9)),
                          ),
                          width: double.infinity,
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                                child: Text(
                                  DateFormat("MMM")
                                      .format(endDate)
                                      .toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 11),
                                ),
                              )),
                        ),
                        Expanded(
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(9),
                                ),
                              ),
                              child: Text(
                                startDate.day.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  VerticalDivider(width: 1,),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xEEf3ba00),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.only(topRight: Radius.circular(9)),
                          ),
                          width: double.infinity,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                            child: Text(
                              DateFormat("MMM")
                                  .format(endDate)
                                  .toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold , fontSize: 11),
                            ),
                          )),
                        ),
                        Expanded(
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(9),
                                ),
                              ),
                              child: Text(
                                endDate.day.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(9),
                          topRight: Radius.circular(9)),
                    ),
                    width: double.infinity,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                          DateFormat("MMM")
                              .format(startDate)
                              .toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(9),
                              bottomRight: Radius.circular(9)),
                        ),
                        child: Text(
                          startDate.day.toString(),
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
