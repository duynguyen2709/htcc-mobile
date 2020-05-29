import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final Function refresh;

  EmptyScreen({this.refresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 2*MediaQuery.of(context).size.height/3 ,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/empty_notification.PNG', width: 270,height: 270,),
                  Text("Bạn hiện chưa có thông báo.", style: TextStyle(color: Colors.lightBlue, fontSize: 22, fontWeight: FontWeight.w500),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
