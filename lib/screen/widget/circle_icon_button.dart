import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData iconData;

  final Function callBack;

  const CircleIconButton({Key key, this.iconData, this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      color: Colors.grey[200].withOpacity(0.5),
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          callBack();
        },
        child: Container(
          height: 30,
          width: 30,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
          child: Icon(iconData),
        ),
      ),
    );
  }
}

//Material(
//shape: CircleBorder(),
//color: Colors.grey[200].withOpacity(0.5),
//child: InkWell(
//customBorder: CircleBorder(),
//onTap: () {
//callBack();
//},
//child: Container(
//height: 30,
//width: 30,
//padding: EdgeInsets.all(4),
//decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
//child: Icon(iconData),
//),
//),
//)
