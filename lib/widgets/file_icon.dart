import 'dart:io';

import 'package:filex/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

class FileIcon extends StatelessWidget {
  final FileSystemEntity file;

  FileIcon({
    Key key,
    @required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File f = File(file.path);
    String _extension = extension(f.path).toLowerCase();
    String mimeType = mime(basename(file.path).toLowerCase());
    String type = mimeType == null ? "" : mimeType.split("/")[0];
    if (_extension == ".apk") {
      return Icon(Icons.android, color: Colors.green);
    } else if (_extension == ".crdownload") {
      return Icon(Feather.download, color: Colors.lightBlue);
    } else if (_extension == ".zip" || _extension.contains("tar")) {
      return Icon(Feather.archive);
    } else if (_extension == ".epub" ||
        _extension == ".pdf" ||
        _extension == ".mobi") {
      return Icon(Feather.file_text, color: Colors.orangeAccent);
    } else {
      switch (type) {
        case "image":
          return Container(
            width: 50,
            height: 50,
            child: Image(
              errorBuilder: (b, o, c) {
                return Icon(Icons.image);
              },
              image: ResizeImage(FileImage(File(file.path)),
                  width: 50, height: 50),
            ),
          );
          break;
        case "video":
          return Container(
            height: 40,
            width: 40,
            child: VideoThumbnail(
              path: file.path,
            ),
          );
          break;
        case "audio":
          return Icon(Feather.music, color: Colors.blue);
          break;
        case "text":
          return Icon(Feather.file_text, color: Colors.orangeAccent);
          break;
        default:
          return Icon(Feather.file);
          break;
      }
    }
  }
}
