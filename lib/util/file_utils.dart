import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thumbnails/thumbnails.dart';

class FileUtils{

  static String waPath = "/storage/emulated/0/WhatsApp/Media/.Statuses";


  /// Convert Byte to KB, MB, .......
  static String formatBytes(bytes, decimals) {
    if(bytes == 0) return "0.0 KB";
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }


  /// Get mime information of a file
  static String getMime(String path){
    File file = File(path);
    String mimeType = mime(file.path);
    return mimeType;
  }

  /// Return all available Storage path
  static Future<List<Directory>> getStorageList() async {
    List<Directory> paths = await getExternalStorageDirectories();
    List<Directory> filteredPaths = List<Directory>();
    for (Directory dir in paths) {
      filteredPaths
          .add(removeDataDirectory(dir.path));
    }
    return filteredPaths;
  }


  static Directory removeDataDirectory(String path){
    return Directory(path.split("Android")[0]);
  }

  static Future<List<FileSystemEntity>> getFilesInPath(String path) async{
    Directory dir = Directory(path);
    return dir.listSync();
  }

  static Future<List<FileSystemEntity>> getAllFiles({bool showHidden}) async{
    List<Directory> storages = await getStorageList();
    List<FileSystemEntity> files = List<FileSystemEntity>();
    for (Directory dir in storages) {
      files.addAll(await getAllFilesInPath(dir.path, showHidden: showHidden));
    }
    return files;
  }

  static Future<List<FileSystemEntity>> getRecentFiles({bool showHidden}) async{
    List<FileSystemEntity> files = await getAllFiles(showHidden: showHidden);
    files.sort((a, b) => File(a.path).lastAccessedSync().compareTo(File(b.path).lastAccessedSync()));
    return files.reversed.toList();
  }

  /// Get all files
  static Future<List<FileSystemEntity>> getAllFilesInPath(String path,{bool showHidden}) async{
    List<FileSystemEntity> files = List<FileSystemEntity>();
    Directory d = Directory(path);
    List<FileSystemEntity> l = d.listSync();
    for (FileSystemEntity file in l) {

      if(file.toString().split(":")[0] != "Directory"){
        if(!showHidden){
          if(!basename(file.path).startsWith(".")){
            files.add(file);
          }
        }else{
          files.add(file);
        }

      }else{
        if(!file.path.contains("/storage/emulated/0/Android")){
//          print(file.path);
          if(!showHidden){
            if(!basename(file.path).startsWith(".")){
              files.addAll(await getAllFilesInPath(file.path, showHidden: showHidden));
            }
          }else{
            files.addAll(await getAllFilesInPath(file.path, showHidden: showHidden));
          }

        }
      }
    }
//    print(files);
    return files;
  }

  /// Get Icon for a file using it's path
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

  /// Get thumbnail for Video Files
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

  static String formatTime(String iso){
    DateTime date = DateTime.parse(iso);
    DateTime now = DateTime.now();
    DateTime yDay = DateTime.now().subtract(Duration(days: 1));
    DateFormat dateFormat = DateFormat("${date.day} ${date.month} ${date.year}");
    DateFormat today = DateFormat("${now.day} ${now.month} ${now.year}");
    DateFormat yesterday = DateFormat("${yDay.day} ${yDay.month} ${yDay.year}");

    if(dateFormat.toString() == today.toString()){
      return "Today ${DateFormat("HH:mm").format(DateTime.parse(iso))}";
    }else if(dateFormat.toString() == yesterday.toString()){
      return "Yesterday ${DateFormat("HH:mm").format(DateTime.parse(iso))}";
    }else{
      return "${DateFormat("MMM dd, HH:mm").format(DateTime.parse(iso))}";
    }
  }
}