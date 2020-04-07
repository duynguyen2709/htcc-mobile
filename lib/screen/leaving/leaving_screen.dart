import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/screen/leaving/info_leaving/info_leaving_screen.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/empty_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/retry_screen.dart';
import 'package:mobx/mobx.dart';

class LeavingScreen extends StatefulWidget {
  LeavingScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LeavingScreenState createState() => _LeavingScreenState();
}

class _LeavingScreenState extends State<LeavingScreen> {
  LeavingStore leavingStore;

  @override
  void initState() {
    super.initState();

    leavingStore = LeavingStore();

    leavingStore.loadData();

    reaction((_) => leavingStore.errorMsg, (String errorMsg) {
      _showErrorDialog(errorMsg);
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
        actions: <Widget>[
          Observer(
            builder: (BuildContext context) {
              return (leavingStore.leavingData != null)
                  ? IconButton(
                      icon: Icon(Icons.assignment),
                      onPressed: () {
                        Navigator.pushNamed(context, Constants.leaving_form_screen,
                            arguments: leavingStore.leavingData.categories);
                      },
                    )
                  : Center();
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
          Observer(
            builder: (BuildContext context) {
              if (leavingStore.isLoading) return LoadingScreen();
              if (leavingStore.leavingData != null) {
                return InfoLeavingScreen(
                  leavingStore: leavingStore,
                );
              } else {
                if (leavingStore.shouldRetry) return RetryScreen(refresh: _refresh);
                return EmptyScreen(refresh: _refresh);
              }
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
