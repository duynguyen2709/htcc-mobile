import 'package:flutter/material.dart';

class AppDialog extends SimpleDialog {
  AppDialog(Widget child, {String title, double radius = 5, bool hasAction = false, Function onAction})
      : super(
            contentPadding: EdgeInsets.all(12.0),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24.0))),
//            title: AppBar(
//                centerTitle: true,
//                shape: RoundedRectangleBorder(
//                    borderRadius:
//                        BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius))),
//                automaticallyImplyLeading: false,
//                title: Text(
//                  title ?? "Thông báo",
//                  style: TextStyle(fontSize: 20, color: Colors.white),
//                  textAlign: TextAlign.center,
//                ),
//                actions: <Widget>[
//                  hasAction
//                      ? IconButton(
//                          icon: Icon(
//                            Icons.add,
//                            color: Colors.white,
//                          ),
//                          onPressed: onAction,
//                        )
//                      : Center()
//                ]),
            children: [child]);

  static showDialogYN(BuildContext context, String content, Function onAgree, Function onDisAgree) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24.0))),
            contentPadding: EdgeInsets.all(12.0),
            backgroundColor: Colors.white,
            content: Container(
              color: Colors.transparent,
              width: 300.0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Xác nhận",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        content,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Hủy",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              onDisAgree();
                              Navigator.of(context, rootNavigator: true).pop('dialog');
                            },
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 30,
                          width: 0.5,
                        ),
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tiếp tục",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              onAgree();
                              Navigator.of(context, rootNavigator: true).pop('dialog');
                            },
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          );
        });
  }

  static showDialogNotify(BuildContext context, String content, Function onOk) {
    showDialog(
      context: context,
      builder: (BuildContext c) {
        return AppDialog(
          Column(
            children: <Widget>[
              Text(
                "Thông báo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20, bottom: 10),
                child: Text(content, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18) , textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "OK",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () async {
                  Navigator.of(c).pop();
                  if (onOk != null) onOk();
                },
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
              )
            ],
          ),
        );
      },
    );
  }
}
