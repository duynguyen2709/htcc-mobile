import 'package:flutter/material.dart';

class ContactInfoLine extends StatelessWidget {
  final String title;
  final String content;
  final Icon icon;

  const ContactInfoLine({Key key, this.title, this.content, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
        Expanded(child: Text(' $content', style: TextStyle( fontSize: 16), maxLines: 100,))
      ],
    );
  }
}
