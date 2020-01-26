import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';

class FileUtils{

  static formatBytes(bytes, decimals) {
    if(bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

//  static Icon setFileIcon(String path) {
//    File file = File(path);
//    String mimeType = mime(file.path);
//    final _extension = filename.split(".").last;
//    if (_extension == "db" || _extension == "sqlite" || _extension == "sqlite3") {
//      return const Icon(Icons.dns);
//    } else if (_extension == "jpg" ||
//        _extension == "jpeg" ||
//        _extension == "png") {
//      return const Icon(Icons.image);
//    }
//    // default
//    return Icon(Icons.description, color: Colors.grey);
//  }
}