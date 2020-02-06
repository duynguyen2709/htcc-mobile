import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarInfoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
                width: (MediaQuery.of(context).size.width) / 4,
                height: (MediaQuery.of(context).size.width) / 4,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/login_header.jpg',
                      image: "https://i.imgur.com/BoN9kdC.png",
                      fit: BoxFit.cover,
                    )) ,),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "Duy Nguyễn",
                textScaleFactor: 1.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "1612145",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.black54),
              ),
            )
          ],
        ));
  }
}