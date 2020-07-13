import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/data/model/qr_code_data.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/checkin/check_in_screen_store.dart';
import 'package:mobx/mobx.dart';

//class CheckInQRCode extends StatefulWidget {
//  final CheckInStore store;
//
//  const CheckInQRCode({Key key, this.store}) : super(key: key);
//  @override
//  _CheckInQRCodeState createState() => _CheckInQRCodeState(store);
//}
//
//class _CheckInQRCodeState extends State<CheckInQRCode> {
//  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//  var qrText = "";
//  QRViewController controller;
//  var _opacity = 1.0;
//  var _alignment = Alignment.center;
//  var _isBack = false;
//  var _timer;
//  final CheckInStore store;
//  User userInfo;
//
//  _CheckInQRCodeState(this.store);
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    Pref.getInstance().then((pref) {
//      userInfo = User.fromJson(json.decode(pref.getString(Constants.USER)));
//    });
////    reaction((_) => store.checkInSuccess, (isSuccess) async {
////      if (isSuccess == true) {
////        _showErrorDialog(false);
////      } else if (isSuccess != null)
////        _showErrorDialog(false);
////    });
////
////    reaction((_) => store.errorAuth, (errorAuthenticate) async {
////      if (errorAuthenticate == true) {
////        _showErrorDialog(true);
////      }
////    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Stack(
//        children: <Widget>[
//
//          Column(
//            children: <Widget>[
//              Expanded(
//                flex: 1,
//                child: QRView(
//                  key: qrKey,
//                  onQRViewCreated: _onQRViewCreated,
//                ),
//              ),
//            ],
//          ),
//          Positioned(
//            top: 36,
//            left: 8,
//            child: IconButton(
//              icon: Icon(Icons.arrow_back, color: Colors.white,),
//              iconSize: 28,
//              onPressed: () {
//                Navigator.pop(context);
//              },
//            ),
//          ),
//          Observer(builder: (_) {
//              if (store.isLoading==true)
//              return Container(
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
//                color: Colors.black45,
//                child: SpinKitCircle(
//                  color: Colors.blue,
//                  size: 50.0,
//                ),
//              );
//            else
//              return Center();
//          }),
//        ],
//      ),
//    );
//  }
//
//  void _onQRViewCreated(QRViewController controller) {
//    this.controller = controller;
//    controller.scannedDataStream.listen((scanData) {
//      setState(() {
//        qrText = scanData;
//      });
//      QRCodeData data = QRCodeData.fromJson(
//          jsonDecode(qrText));
//      store.checkInQR(getCheckInParam(data));
//    });
//  }
//
//  CheckInParam getCheckInParam(QRCodeData data) {
//    return new CheckInParam(
//        username: userInfo.username,
//        companyId: userInfo.companyId,
//        clientTime: data.genTime,
//        latitude: 0,
//        longitude: 0,
//        officeId: data.officeId,
//        type: store.checkInInfo.detailCheckIn.length == 0
//            ? 1
//            : store.checkInInfo.detailCheckIn[store.checkInInfo.detailCheckIn.length - 1].type == 1
//            ? 2
//            : 1,
//        usedWifi: false,
//        qrCodeId: data.qrCodeId,
//        ip: "");
//  }
//  @override
//  void dispose() {
//    controller?.dispose();
//    super.dispose();
//  }
//
//  void _showErrorDialog(bool isAuthErr) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text(Constants.titleErrorDialog),
//          content:
//          new Text(store.checkInSuccess ? store.message : store.errorMsg),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text(Constants.buttonErrorDialog),
//              onPressed: () {
//                Navigator.of(context).pop();
//                if (store.checkInSuccess == true)
//                  Navigator.pop(context, "success");
//                if (isAuthErr)
//                  Navigator.pushReplacementNamed(
//                      context, Constants.login_screen);
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//}

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    scanQR();
  }


  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true,ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}