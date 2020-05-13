import 'package:flutter/material.dart';

class RetryScreen extends StatelessWidget {
  final Function refresh;

  final String msg;

  RetryScreen({this.refresh, this.msg = "Đã có lỗi xảy ra. Vui lòng thử lại!"});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(msg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Icon(Icons.rotate_left), Text("Thử lại")],
          )
        ],
      ),
      onPressed: () {
        refresh();
      },
    );
  }
}
