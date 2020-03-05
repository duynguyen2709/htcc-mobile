import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final StatelessWidget leading;
  final String title;
  final bool following;
  final Function() onTap;

  const Section({Key key, this.leading, this.title, this.following, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 4, 8, 2),
        child: ListTile(
          leading: leading,
          title: Text(title),
          trailing: following? Icon(Icons.arrow_forward_ios, color: Colors.black,) : null,
        ),
      ),
      onTap: () => onTap(),
      splashColor: Colors.grey,
    );
  }
}
