import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ImageThumbnail extends StatefulWidget {
  final File file;

  ImageThumbnail({this.file});

  @override
  _ImageThumbnailState createState() => _ImageThumbnailState();
}

class _ImageThumbnailState extends State<ImageThumbnail> {
  String thumb;

  // Save thumbnail to `cache`
  getThumb() async {
    var directory = await getTemporaryDirectory();
    print(directory.path);
    File file = widget.file;
    Directory cacheDir = Directory('${directory.path}/imgCache/');
    if(!cacheDir.existsSync())
      cacheDir.createSync();

    String thumbPath = '${cacheDir.path}${basename(file.path)}';
    print(thumbPath);
    File thumbFile = File(thumbPath);
    if (!thumbFile.existsSync()) {
      SendPort mainToIsolateStream = await initIsolate();
      mainToIsolateStream.send([file, thumbFile]);
    }else{
      thumb = thumbFile.path;
      setState(() {});
    }
  }

  Future<SendPort> initIsolate() async {
    Completer completer = new Completer<SendPort>();
    ReceivePort isolateToMainStream = ReceivePort();

    isolateToMainStream.listen((data) {
      if (data is SendPort) {
        SendPort mainToIsolateStream = data;
        completer.complete(mainToIsolateStream);
      } else {
        thumb = data;
        if(mounted)
          setState(() {});
      }
    });

    await Isolate.spawn(myIsolate, isolateToMainStream.sendPort);
    return completer.future;
  }

  static void myIsolate(SendPort isolateToMainStream) {
    ReceivePort mainToIsolateStream = ReceivePort();
    isolateToMainStream.send(mainToIsolateStream.sendPort);

    // receive the file from the main thread
    mainToIsolateStream.listen((data) async {
      File file = data[0];
      File thumbFile = data[1];
      img.Image image = img.decodeImage(file.readAsBytesSync());
      img.Image thumbnail = img.copyResize(image, width: 150);
      thumbFile.createSync();
      thumbFile..writeAsBytesSync(img.encodePng(thumbnail));
      // send the thumbnail path back to the main thread
      isolateToMainStream.send(thumbFile.path);
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
