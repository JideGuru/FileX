import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class BrowseProvider extends ChangeNotifier{
  BrowseProvider(){
    checkSpace();
  }
  List<FileSystemEntity> availableStorage = List();

  int totalSpace = 0;
  int freeSpace = 0;
  int totalSDSpace = 0;
  int freeSDSpace = 0;
  int usedSpace = 0;
  int usedSDSpace = 0;
  bool loading = true;

  checkSpace() async{
    setLoading(true);
    List<FileSystemEntity> l = await getExternalStorageDirectories();
    print(l);
    availableStorage.addAll(l);
    notifyListeners();
    MethodChannel platform = MethodChannel('dev.jideguru.filex/storage');
    var free = await platform.invokeMethod("getStorageFreeSpace");
    var total = await platform.invokeMethod("getStorageTotalSpace");
    setFreeSpace(free);
    setTotalSpace(total);
    setUsedSpace(total-free);
    if(l.length > 1){
      var freeSD = await platform.invokeMethod("getExternalStorageFreeSpace");
      var totalSD = await platform.invokeMethod("getExternalStorageTotalSpace");
      setFreeSDSpace(freeSD);
      setTotalSDSpace(totalSD);
      setUsedSDSpace(totalSD-freeSD);
    }
    setLoading(false);
  }

  void setFreeSpace(value) {
    freeSpace = value;
    notifyListeners();
  }

  void setTotalSpace(value) {
    totalSpace = value;
    notifyListeners();
  }
  void setUsedSpace(value) {
    usedSpace = value;
    notifyListeners();
  }

  void setFreeSDSpace(value) {
    freeSDSpace = value;
    notifyListeners();
  }

  void setTotalSDSpace(value) {
    totalSDSpace = value;
    notifyListeners();
  }
  void setUsedSDSpace(value) {
    usedSDSpace = value;
    notifyListeners();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void showToast(value) {
    Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
    );
    notifyListeners();
  }
}