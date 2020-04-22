import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CheckInCameraPage extends StatefulWidget {
  CheckInCameraPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CheckInCameraPageState createState() => _CheckInCameraPageState();
}

class _CheckInCameraPageState extends State<CheckInCameraPage>
    with WidgetsBindingObserver {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  int currentType = 0;
  var imagePath;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                        imagePath = join(
                          // Store the picture in the temp directory.
                          // Find the temp directory using the `path_provider` plugin.
                          (await getTemporaryDirectory()).path,
                          '${DateTime.now()}.png',
                        );

                        // Attempt to take a picture and log where it's been saved.
                        await _controller.takePicture(imagePath);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DisplayImageScreen(imagePath: imagePath),
                          ),
                        );
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

  const DisplayImageScreen({Key key, this.imagePath}) : super(key: key);

  @override
  _DisplayImageScreenState createState() => _DisplayImageScreenState(imagePath);
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  final String imagePath;
  var _opacity = 1.0;
  var _alignment = Alignment.center;
  var _isBack = false;
  var _timer;

  _DisplayImageScreenState(this.imagePath);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: Image.file(File(imagePath), width: MediaQuery.of(context).size.width,)),
            Positioned(
              bottom: 0,
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
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
                          _timer = new Timer(const Duration(seconds: 5), () {
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
                              _alignment = _alignment == Alignment.bottomRight
                                  ? Alignment.center
                                  : Alignment.bottomRight;
                              _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                            });

                          //send to server
                          
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
          ],
        ),
      ),
    );
  }

  Future<MultipartFile> _getMultipartFile(File file) async {
    if(file!=null) {
      String fileName = file.path.split('/').last;
      var res = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );
      return res;
    }
    else return null;
  }
}
