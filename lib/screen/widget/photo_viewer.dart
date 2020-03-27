import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const PhotoViewer({Key key, this.images, this.initialIndex})
      : super(key: key);

  @override
  _PhotoViewerState createState() => _PhotoViewerState(images, initialIndex);
}

class _PhotoViewerState extends State<PhotoViewer> {
  final List<String> images;
  final int initialIndex;
  int currentPosition;
  PageController pageController;

  _PhotoViewerState(this.images, this.initialIndex) {
    pageController = PageController(initialPage: initialIndex);
    currentPosition = initialIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(images[index]),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
                );
              },
              itemCount: images.length,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes,
                  ),
                ),
              ),
              backgroundDecoration: BoxDecoration(
                color: Colors.black,
              ),
              pageController: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPosition = index + 1;
                });
              },
            ),
            Positioned(
              top: 40,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              top: 40,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,

                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Text(
                      "$currentPosition/${images.length}",
                      style: TextStyle( color: Colors.grey, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
