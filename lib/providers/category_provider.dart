import 'dart:io';

import 'package:filex/util/file_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:mime_type/mime_type.dart';

class CategoryProvider extends ChangeNotifier{
  bool loading = false;
  List<FileSystemEntity> downloads = List();
  List<String> downloadTabs = List();

  List<FileSystemEntity> images = List();
  List<String> imageTabs = List();

  List<FileSystemEntity> videos = List();
  List<String> videoTabs = List();


  getDownloads() async{
    setLoading(true);
    downloadTabs.clear();
    downloads.clear();
    downloadTabs.add("All");
    List<Directory> storages = await FileUtils.getStorageList();
//    print(storages.toString());
    storages.forEach((dir){
      List<FileSystemEntity> files = Directory(dir.path+"Download").listSync();
      files.forEach((file){
        downloads.add(file);
        downloadTabs.add(file.path.split("/")[file.path.split("/").length-2]);
        downloadTabs = downloadTabs.toSet().toList();
        setLoading(false);
        notifyListeners();
      });
    });
  }

  getImages() async{
    setLoading(true);
    imageTabs.clear();
    images.clear();
    imageTabs.add("All");
    List<FileSystemEntity> files = await FileUtils.getAllFiles(showHidden: true);
    files.forEach((file){
      String mimeType = mime(file.path);
      if(mimeType != null){
        if(mimeType.split("/")[0] == "image"){
          images.add(file);
          imageTabs.add("${file.path.split("/")[file.path.split("/").length-2]}");
          imageTabs = imageTabs.toSet().toList();
          setLoading(false);
          notifyListeners();
        }
      }
    });
  }

  getVideos() async{
    setLoading(true);
    videoTabs.clear();
    videos.clear();
    videoTabs.add("All");
    List<FileSystemEntity> files = await FileUtils.getAllFiles(showHidden: true);
    files.forEach((file){
      String mimeType = mime(file.path);
      if(mimeType != null){
        if(mimeType.split("/")[0] == "video"){
          videos.add(file);
          videoTabs.add("${file.path.split("/")[file.path.split("/").length-2]}");
          videoTabs = videoTabs.toSet().toList();
          setLoading(false);
          notifyListeners();
        }
      }
    });
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }
}