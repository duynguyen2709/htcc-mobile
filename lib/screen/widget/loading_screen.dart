import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitCircle(
            color: Colors.blue,
            size: 50.0,
          ),
          Text(
            'Đang xử lý',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}
