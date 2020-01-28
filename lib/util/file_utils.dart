import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thumbnails/thumbnails.dart';

class FileUtils{

  static formatBytes(bytes, decimals) {
    if(bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  static Future<int> getFreeSpace() async {
    MethodChannel platform = const MethodChannel('dev.jideguru.filex/storage');
    int freeSpace = await platform.invokeMethod("getStorageFreeSpace");
    return freeSpace;
  }

  static String getMime(String path){
    File file = File(path);
    String mimeType = mime(file.path);
    return mimeType;
  }

  static Future<Widget> setFileIcon(FileSystemEntity f) async{
    if (f is Directory) {
      return Icon(
        Feather.folder,
      );
    } else {
      String path = f.path;
      File file = File(path);
      String _extension = extension(path);
      String mimeType = mime(file.path);
      if (_extension == ".apk") {
        return Icon(
          Icons.android,
          color: Colors.green,
        );
      }else if(_extension == ".zip" || _extension.contains("tar")){
        return Icon(
          Feather.archive,
        );
      }else{
        switch (mimeType.split("/")[0]) {
          case "image":
            {
              return Image.file(
                file,
              );
            }
            break;

          case "video":
            {
              return Image.file(
                File(await Thumbnails.getThumbnail(
                  thumbnailFolder: (await getApplicationSupportDirectory()).path,
                  videoFile: file.path,
                  imageType: ThumbFormat.PNG,
                  quality: 30,
                ),),
              );
            }
            break;

          case "audio":
            {
              return Icon(
                Feather.music,
                color: Colors.blue,
              );
            }
            break;

          case "text":
            {
              return Icon(
                Feather.file_text,
                color: Colors.purple,
              );
            }
            break;

          default:
            {
              return Icon(
                Feather.file,
              );
            }
            break;
        }
      }
    }
  }
}