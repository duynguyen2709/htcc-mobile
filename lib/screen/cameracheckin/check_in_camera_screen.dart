import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  var ImagePath;

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
    _controller = CameraController(frontCamera, ResolutionPreset.high);
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
                  Image(
                    image: AssetImage("./assets/camera_capture.png"),
                    width: 80,
                    height: 80,
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
