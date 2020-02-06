import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSelectionHome extends StatelessWidget {
  CustomSelectionHome({Key key, this.title, this.icon, this.route}) : super(key: key);
  final String title;
  final Image icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToNextScreen(context, route);
      },
      child: Container(
        height: (MediaQuery.of(context).size.width) / 3.75,
        width: (MediaQuery.of(context).size.width) / 2.25,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withAlpha(50),
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(3, 3)),
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon,
            Container(
              child: Text(title, textAlign: TextAlign.center),
              padding: EdgeInsets.all(8),
            )
          ],
        ),
      ),
    );
  }

  void navigateToNextScreen(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}