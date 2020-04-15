import 'package:flutter/material.dart';

class RoundText extends StatelessWidget {
  final String title;

  final Color colorText;

  final Color colorBackground;

  RoundText({this.title, this.colorText, this.colorBackground});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colorBackground,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Center(
        child: Text(title, style: TextStyle(
          color: colorText,
          fontSize: 12,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
