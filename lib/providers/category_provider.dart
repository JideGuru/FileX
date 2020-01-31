import 'dart:io';

import 'package:filex/util/file_utils.dart';
import 'package:flutter/foundation.dart';

class CategoryProvider extends ChangeNotifier{
  bool loading = false;
  List<FileSystemEntity> downloads = List();
  List<String> downloadTabs = List();

  getDownloads() async{
    setLoading(true);
    downloadTabs.add("All");
    List<Directory> storages = await FileUtils.getStorageList();
    print(storages.toString());
    storages.forEach((dir){
      List<FileSystemEntity> files = Directory(dir.path+"Download").listSync();
      files.forEach((file){
        downloads.add(file);
        downloadTabs.add(file.path.split("/")[file.path.split("/").length-2]);
        downloadTabs.toSet().toList();
        setLoading(false);
        notifyListeners();
      });
    });
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }
}