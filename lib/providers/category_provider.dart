import 'dart:io';

import 'package:filex/util/file_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:mime_type/mime_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier{
  CategoryProvider(){
    getHidden();
    getSort();
  }

  bool loading = false;
  List<FileSystemEntity> downloads = List();
  List<String> downloadTabs = List();

  List<FileSystemEntity> images = List();
  List<String> imageTabs = List();

  List<FileSystemEntity> audio = List();
  List<String> audioTabs = List();

  bool showHidden = true;
  int sort = 0;

  getDownloads() async{
    setLoading(true);
    downloadTabs.clear();
    downloads.clear();
    downloadTabs.add("All");
    List<Directory> storages = await FileUtils.getStorageList();
    storages.forEach((dir){
      List<FileSystemEntity> files = Directory(dir.path+"Download").listSync();
      files.forEach((file){
        downloads.add(file);
        downloadTabs.add(file.path.split("/")[file.path.split("/").length-2]);
        downloadTabs = downloadTabs.toSet().toList();
        notifyListeners();
      });
    });
    setLoading(false);
  }

  getImages(String type) async{
    setLoading(true);
    imageTabs.clear();
    images.clear();
    imageTabs.add("All");
    List<FileSystemEntity> files = await FileUtils.getAllFiles(showHidden: showHidden);
    files.forEach((file){
      String mimeType = mime(file.path) == null
          ? ""
          : mime(file.path);
      if(mimeType.split("/")[0] == type){
        images.add(file);
        imageTabs.add("${file.path.split("/")[file.path.split("/").length-2]}");
        imageTabs = imageTabs.toSet().toList();
      }
      notifyListeners();
    });
    setLoading(false);
  }


  getAudios(String type) async{
    setLoading(true);
    audioTabs.clear();
    audio.clear();
    audioTabs.add("All");
    List<FileSystemEntity> files = await FileUtils.getAllFiles(showHidden: showHidden);
    files.forEach((file){
      String mimeType = mime(file.path);
      if(mimeType != null){
        if(mimeType.split("/")[0] == type){
          if(type == "text" && mimeType.contains("pdf")){
            audio.add(file);
          }
          audio.add(file);
          audioTabs.add("${file.path.split("/")[file.path.split("/").length-2]}");
          audioTabs =  audioTabs.toSet().toList();
        }
        notifyListeners();
      }
    });
    setLoading(false);
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  setHidden(value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("hidden", value);
    showHidden = value;
    notifyListeners();
  }

  getHidden() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool h = prefs.getBool("hidden") == null?true:prefs.getBool("hidden");
    setHidden(h);
  }

  Future setSort(value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("sort", value);
    sort = value;
    notifyListeners();
  }

  getSort() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int h = prefs.getInt("sort") == null
        ? 0
        : prefs.getInt("sort");
    setSort(h);
  }
}