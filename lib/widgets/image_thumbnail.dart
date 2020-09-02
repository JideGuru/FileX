import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';

class ImageThumbnail extends StatefulWidget {
  final File file;

  ImageThumbnail({this.file});

  @override
  _ImageThumbnailState createState() => _ImageThumbnailState();
}

class _ImageThumbnailState extends State<ImageThumbnail> {
  String thumb;
//  Isolate _isolate;
//  ReceivePort _receivePort;

  getThumb() async {
    File file = widget.file;
    String thumbPath =
        '${file.path}thumb.${extension(file.path)}';
    File thumbFile = File(thumbPath);
    if (!thumbFile.existsSync()) {
      SendPort mainToIsolateStream = await initIsolate();
      mainToIsolateStream.send(file);
//      _startIsolate();
    }else{
      thumb = thumbFile.path;
      setState(() {});
    }
  }

//  void _startIsolate() async {
//    _receivePort = ReceivePort();
//    _isolate = await Isolate.spawn(compressImage, _receivePort.sendPort);
//    _receivePort.listen(_handleMessage, onDone:() {
//      print("done!");
//    });
//  }
//
//  static void compressImage(SendPort sendPort) async {
//    String thumbPath =
//        '${file.path}thumb${extension(file.path)}';
//    File thumbFile = File(thumbPath);
//    img.Image image = img.decodeImage(file.readAsBytesSync());
//    img.Image thumbnail = img.copyResize(image, width: 120);
//    thumbFile..writeAsBytesSync(img.encodePng(thumbnail));
//    sendPort.send(thumbFile.path);
//  }
//
//  void _handleMessage(dynamic data) {
//    print('RECEIVED: ' + data);
//    setState(() {
//      thumb = data;
//    });
//  }

  Future<SendPort> initIsolate() async {
    Completer completer = new Completer<SendPort>();
    ReceivePort isolateToMainStream = ReceivePort();

    isolateToMainStream.listen((data) {
      if (data is SendPort) {
        SendPort mainToIsolateStream = data;
        completer.complete(mainToIsolateStream);
      } else {
        print('[isolateToMainStream] $data');
        thumb = data;
//        if(mounted)
//          setState(() {});
      }
    });

    Isolate myIsolateInstance = await
        Isolate.spawn(myIsolate, isolateToMainStream.sendPort);
    return completer.future;
  }

  static void myIsolate(SendPort isolateToMainStream) {
    ReceivePort mainToIsolateStream = ReceivePort();
    isolateToMainStream.send(mainToIsolateStream.sendPort);

    mainToIsolateStream.listen((data) {
      print('[mainToIsolateStream] $data');

      File file = data;
      String thumbPath =
          '${file.path}thumb${extension(file.path)}';
      File thumbFile = File(thumbPath);
      img.Image image = img.decodeImage(file.readAsBytesSync());
      img.Image thumbnail = img.copyResize(image, width: 120);
      thumbFile..writeAsBytesSync(img.encodePng(thumbnail));
      isolateToMainStream.send(thumbPath);
      exit(0);
    });
  }

  @override
  void initState() {
    super.initState();
    getThumb();
  }

  @override
  Widget build(BuildContext context) {
    return thumb == null
        ? SizedBox()
        : Image.file(
            File(thumb),
            fit: BoxFit.cover,
          );
  }
}
