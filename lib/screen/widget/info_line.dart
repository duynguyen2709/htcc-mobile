import 'package:flutter/material.dart';

class InfoLine extends StatelessWidget {
  final String title;
  final String content;

  const InfoLine({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              "$title :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Flexible(child: Text(content, style: TextStyle( fontSize: 16), maxLines: 100,))
        ],
      ),
    );
  }
}
