import 'package:flutter/material.dart';

class AppDialog extends SimpleDialog {
  AppDialog(Widget child, {String title, double radius = 5, bool hasAction = false, Function onAction})
      : super(
            titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
            contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius))),
            title: AppBar(
                centerTitle: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius))),
                automaticallyImplyLeading: false,
                title: Text(
                  title ?? "Thông báo",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  hasAction
                      ? IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: onAction,
                        )
                      : Center()
                ]),
            children: [child]);

  static showDialogYN(BuildContext context, String content, Function onAgree, Function onDisAgree) {
    showDialog(
        context: context,
        builder: (c) {
          return AppDialog(Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20, bottom: 10),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Hủy bỏ"),
                        onPressed: () {
                          onDisAgree();
                          Navigator.pop(c);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Đồng ý"),
                        onPressed: () {
                          onAgree();
                          Navigator.pop(c);
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ));
        });
  }

  static showDialogNotify(BuildContext context, String content, Function onOk) {
    showDialog(
      context: context,
      builder: (BuildContext c) {
        // return object of type Dialog
        return AppDialog(
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20, bottom: 10),
                child: Text(content, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Container(width: double.infinity, alignment: Alignment.center, child: Text("Ok")),
                  onPressed: () {
                    onOk();
                    Navigator.pop(c);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
