import 'dart:async';

import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final Function onPressed;
  final Function onTitleTapped;

  @override
  final Size preferredSize;

  CustomAppBar({@required this.title, @required this.child, @required this.onPressed, this.onTitleTapped})
      : preferredSize = Size.fromHeight(60.0);


  @override
  State<StatefulWidget> createState() => CustomAppBarState(title,child,onPressed,onTitleTapped);
}

class CustomAppBarState extends State<CustomAppBar>{
  final String title;
  final Widget child;
  final Function onPressed;
  final Function onTitleTapped;
  double _width = 20;
  String _title="";
  Timer _timer;
  Timer _timer1;

  CustomAppBarState(this.title, this.child, this.onPressed, this.onTitleTapped);

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = new Timer(const Duration(seconds: 2), () {
      setState(() {
        _width = MediaQuery.of(context).size.width/1.25;
      });
    });

    _timer1 = Timer(Duration(seconds: 3),(){
      setState(() {
       _title = title;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Hero(
            tag: 'title',
            transitionOnUserGestures: true,
            child: Card(
              elevation: 10,
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                width: _width ,
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            _title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white
                              // color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.short_text, size: 35,color: Colors.white,),
                      onPressed: onPressed,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _timer1.cancel();
  }

}


ShapeBorder kBackButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);

Widget kBackBtn = Icon(
  Icons.arrow_back_ios,
  // color: Colors.black54,
);