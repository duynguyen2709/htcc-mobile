import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/screen/leaving/info_leaving/info_leaving_screen.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/empty_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/retry_screen.dart';

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
    leavingStore.init();
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
          IconButton(
            icon: Icon(Icons.assignment),
            onPressed: () {
              Navigator.pushNamed(context, Constants.leaving_form_screen);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (BuildContext context) {
              if (leavingStore.isLoading) return LoadingScreen();
              if (leavingStore.infoLeaving != null) {
                return InfoLeavingScreen();
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

  Future<void> _refresh() async {}
}
