import 'package:flutter/material.dart';

class RetryScreen extends StatelessWidget {
  final Function refresh;

  RetryScreen({this.refresh});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Đã có lỗi xảy ra. Vui lòng thử lại!"),
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
