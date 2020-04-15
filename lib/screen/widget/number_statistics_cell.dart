import 'dart:ffi';

import 'package:flutter/material.dart';

class NumberStatisticCell extends StatefulWidget {
  final double number;
  final String content;
  final Color colorContent;
  final int width;

  const NumberStatisticCell({Key key, this.number, this.content, this.colorContent, this.width}) : super(key: key);
  @override
  _NumberStatisticCellState createState() => _NumberStatisticCellState(number,content,colorContent,width);
}

class _NumberStatisticCellState extends State<NumberStatisticCell> {
  final double number;
  final String content;
  final Color colorContent;
  final int width;

  _NumberStatisticCellState(this.number, this.content, this.colorContent, this.width);
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width==null ? double.infinity: width,
      height: width==null ? double.infinity: width,
      margin: EdgeInsets.all(4),
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "$number",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Container(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  content,
                  style: TextStyle(
                      color: colorContent, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}
