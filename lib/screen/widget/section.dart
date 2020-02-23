import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Icon leading;
  final String title;
  final bool following;
  final Function() onTap;

  const Section({Key key, this.leading, this.title, this.following, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
          title: Row(
        children: <Widget>[
          Container(
            width: 20,
          ),
          Icon(Icons.person),
          Container(
            width: 20,
          ),
          Expanded(
              child: Text(
            "Thông tin cá nhân",
            style: TextStyle(fontSize: 18),
          )),
          Icon(Icons.arrow_forward_ios),
          Container(
            width: 20,
          )
        ],
      )),
      onTap: ()=> onTap(),
      splashColor: Colors.grey,
    );
  }
}
