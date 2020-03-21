
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatefulWidget {
  PickImageWidget({
    Key key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _PickImageWidgetState createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  File _pickedImage;

  void _pickImage() async {
    final imageSource = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(title: Text("Select Image")),
            _createTile(context, "Camera", Icons.camera, () {
              Navigator.pop(context, ImageSource.camera);
            }),
            _createTile(context, "Gallery", Icons.collections, () {
              Navigator.pop(context, ImageSource.gallery);
            })
          ],
        ));

    if (imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        setState(() => _pickedImage = file);
      }
    }
  }

  ListTile _createTile(
      BuildContext context, String _title, IconData icon, Function action) {
    return ListTile(
      title: Text(_title),
      leading: Icon(icon),
      onTap: () {
//        Navigator.pop(context);
        action();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return InkWell(
      child: Container(
        height: MediaQuery.of(context).size.width / 3.75,
        width: MediaQuery.of(context).size.width / 3.75,
        margin: EdgeInsets.fromLTRB(0, 12, 8, 0),
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: _pickedImage == null
                    ? AssetImage('./assets/add_image.png')
                    : FileImage(_pickedImage))),
      ),
      onTap: () => _pickImage(),
    );
  }
}