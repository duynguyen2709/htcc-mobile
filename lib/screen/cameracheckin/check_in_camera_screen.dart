import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/local/shared_preference.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_info.dart';
import 'package:hethongchamcong_mobile/data/model/check_in_param.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/checkin/check_in_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/dialog/app_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInCameraPage extends StatefulWidget {
  final CheckInStore store;

  CheckInCameraPage({Key key, this.title, this.store}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CheckInCameraPageState createState() => _CheckInCameraPageState(store);
}

class _CheckInCameraPageState extends State<CheckInCameraPage>
    with WidgetsBindingObserver {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  int currentType = 0;
  var imagePath;
  final CheckInStore store;

  _CheckInCameraPageState(this.store);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras[currentType];
    _controller = CameraController(frontCamera, ResolutionPreset.high,
        enableAudio: false);
    _initializeControllerFuture = _controller.initialize();
    if (!this.mounted) {
      return;
    } else {
      setState(() {
        isCameraReady = true;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / (size.height);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Điểm Danh"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CameraPreview(_controller),
                      ),
                    );
                  } else {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Otherwise, display a loading indicator.
                  }
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                  ),
                  InkWell(
                    child: Image(
                      image: AssetImage("./assets/camera_capture.png"),
                      width: 80,
                      height: 80,
                    ),
                    onTap: () async {
                      // Take the Picture in a try / catch block. If anything goes wrong,
                      // catch the error.
                      try {
                        // Ensure that the camera is initialized.
                        await _initializeControllerFuture;

                        // Construct the path where the image should be saved using the path
                        // package.
                        imagePath = Path.join(
                          // Store the picture in the temp directory.
                          // Find the temp directory using the `path_provider` plugin.
                          (await getTemporaryDirectory()).path,
                          '${DateTime.now()}.png',
                        );

                        // Attempt to take a picture and log where it's been saved.
                        await _controller.takePicture(imagePath);
                        final res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayImageScreen(
                              imagePath: imagePath,
                              store: store,
                            ),
                          ),
                        );
                        if (res != null) {
                          Navigator.pop(context, "Post Image Success");
                        }
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        print(e);
                      }
                    },
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Image(
                        image: AssetImage("./assets/front_camera.png"),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    onTap: () => _switchCamera(),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _switchCamera() {
    if (currentType == 1)
      currentType = 0;
    else
      currentType = 1;
    _initializeCamera();
  }
}

class DisplayImageScreen extends StatefulWidget {
  final String imagePath;
  final CheckInStore store;

  const DisplayImageScreen({Key key, this.imagePath, this.store})
      : super(key: key);

  @override
  _DisplayImageScreenState createState() =>
      _DisplayImageScreenState(imagePath, store);
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  final String imagePath;
  CheckInParam param;
  final CheckInStore store;
  var _opacity = 1.0;
  var _alignment = Alignment.center;
  var _isBack = false;
  var _timer;
  var _connectionStatus = 'Unknow';
  var wifiIP = '';
  User userInfo;
  OfficeDetail curOffice;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  _DisplayImageScreenState(this.imagePath, this.store);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curOffice = store.checkInInfo.officeList[0];
    Pref.getInstance().then((pref) {
      userInfo = User.fromJson(json.decode(pref.getString(Constants.USER)));
    });
    //catch connectivity change
    connectivity = Connectivity();
    subscription = connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.wifi) {
        wifiIP = await (Connectivity().getWifiIP());
        _connectionStatus = "wifi";
      } else if (result == ConnectivityResult.mobile) {
        _connectionStatus = "mobile";
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  CheckInParam getCheckInParam() {
    return new CheckInParam(
        username: userInfo.username,
        companyId: userInfo.companyId,
        clientTime: DateTime.now().millisecondsSinceEpoch,
        latitude: 0,
        longitude: 0,
        officeId: curOffice.officeId,
        type: store.checkInInfo.detailCheckIn.length == 0
            ? 1
            : store.checkInInfo.detailCheckIn[store.checkInInfo.detailCheckIn.length - 1].type == 1 ? 2 : 1,
        usedWifi: _connectionStatus.compareTo("wifi") == 0 ? true : false,
        ip: _connectionStatus.compareTo("wifi") == 0 ? wifiIP : '');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gửi ảnh điểm danh')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
        child: Stack(
          children: <Widget>[
            Column(
              children: [     Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.file(
                  File(imagePath),
                  height: MediaQuery.of(context).size.height*0.6,
                ),
              ),
                curOffice != null
                    ? Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  margin: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: FormField<OfficeDetail>(
                    builder: (FormFieldState<OfficeDetail> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Chi nhánh",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          fillColor: Colors.white,
                        ),
                        isEmpty:
                        curOffice.officeId == '' || curOffice == null,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<OfficeDetail>(
                            value: curOffice,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                curOffice = newValue;
                              });
                            },
                            items: store.checkInInfo.officeList
                                .map((OfficeDetail value) {
                              return DropdownMenuItem<OfficeDetail>(
                                value: value,
                                child: Text(value.officeId),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : Container(),],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      duration: Duration(seconds: _isBack ? 0 : 4),
                      alignment: _alignment,
                      child: AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(seconds: _isBack ? 0 : 3),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      padding: EdgeInsets.only(left: 6),
                      alignment: Alignment.center,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () async {
                          if (_timer != null) _timer.cancel();
                          _timer =
                          new Timer(const Duration(seconds: 5), () {
                            if (mounted) {
                              setState(() {
                                _isBack = true;
                                _alignment = Alignment.center;
                                _opacity = 1.0;
                              });
                            }
                          });
                          if (mounted)
                            setState(() {
                              _isBack = false;
                              _alignment =
                              _alignment == Alignment.bottomRight
                                  ? Alignment.center
                                  : Alignment.bottomRight;
                              _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                            });

                          //send to server
                          MultipartFile image =
                          await _getMultipartFile(File(imagePath));
                          store.checkInImage(getCheckInParam(), image);
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Observer(builder: (_) {
              if (store.isLoading)
                return Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  color: Colors.black45,
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                );
              else
                return Center();
            }),
          ],
        ),
      ),
    );
  }

  Future<MultipartFile> _getMultipartFile(File file) async {
    if (file != null) {
      String fileName = file.path.split('/').last;
      var res = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );
      return res;
    } else
      return null;
  }
}
