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
                width: (MediaQuery.of(context).size.width) / 4.5,
                height: (MediaQuery.of(context).size.width) / 4.5,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/login_header.png',
                      image: 'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    )) ,),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "Duy Nguyễn",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "1612145",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
            )
          ],
        ));
  }
}