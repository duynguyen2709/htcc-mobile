import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/screen/leaving/info_leaving/info_leaving_screen.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_form/leaving_form.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/main_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/empty_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/retry_screen.dart';
import 'package:mobx/mobx.dart';

class LeavingScreen extends StatefulWidget {
  final MainScreenState parent;

  LeavingScreen({Key key, this.title, this.parent}) : super(key: key);

  final String title;

  @override
  _LeavingScreenState createState() => _LeavingScreenState(parent);
}

class _LeavingScreenState extends State<LeavingScreen> {
  LeavingStore leavingStore;
  final MainScreenState parent;

  _LeavingScreenState(this.parent);

  @override
  void initState() {
    super.initState();

    leavingStore = LeavingStore();

    leavingStore.loadData();

    reaction((_) => leavingStore.errorMsg, (String errorMsg) {
      _showErrorDialog(errorMsg);
    });

    reaction((_) => leavingStore.errAuth, (errAuth) {
     if(errAuth==true) _showErrorDialog(leavingStore.errorMsg);
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(Constants.titleErrorDialog),
          content: Text(errorMessage),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(Constants.buttonErrorDialog),
              onPressed: () {
                Navigator.of(context).pop();
                if(leavingStore.errAuth){
                  Navigator.pushReplacementNamed(
                      context, Constants.login_screen);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xem lịch"),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.assignment),
            onPressed: () async {
              var res = await Navigator.pushNamed(context, Constants.leaving_form_screen,
                  arguments: leavingStore);
              if (res!=null) leavingStore.loadData();
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          InfoLeavingScreen(
            leavingStore: leavingStore,
            mainScreenInstance: parent,
          ),
          Observer(
            builder: (BuildContext context) {
              if (leavingStore.isLoading) return LoadingScreen();
              else return Container();
            },
          )
        ],
      ),
    );
  }

  Future<void> _refresh() async {
    await leavingStore.loadData();
  }
}
