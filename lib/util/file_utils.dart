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

  static String waPath = "/storage/emulated/0/WhatsApp/Media/.Statuses";


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

  static Future<Widget> setFileIcon(String path) async{
    if (FileSystemEntity.isDirectorySync(path)) {
      return Icon(
        Feather.folder,
      );
    } else {
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
                height: 40,
                width: 40,
              );
            }
            break;

          case "video":
            {

              return Image.file(
                File((await getVideoThumbnail(file.path))),
                height: 40,
                width: 40,
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
                color: Colors.orangeAccent,
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

  static Future<String> getVideoThumbnail(String path) async{
    var dir = await getExternalStorageDirectory();
    String fi = await Thumbnails.getThumbnail(
      thumbnailFolder: dir.path,
      videoFile: path,
      imageType: ThumbFormat.PNG,
      quality: 30,
    );
    return fi;
  }
}