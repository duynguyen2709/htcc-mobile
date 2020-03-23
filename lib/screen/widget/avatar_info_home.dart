import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarInfoHome extends StatelessWidget {
  final String avatar;
  final String username;
  final String employeeId;

  const AvatarInfoHome({Key key, this.avatar, this.username, this.employeeId}) : super(key: key);
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
                    child: (avatar!= null )?FadeInImage.assetNetwork(
                      placeholder: 'assets/human_error.png',
                      image: avatar,
                      fit: BoxFit.cover,
                    ) : Image.asset("./assets/human_error.png")) ,),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                username!=null? username :"",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                employeeId!=null?  employeeId :"" ,
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