import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class BrowseProvider extends ChangeNotifier{
  BrowseProvider(){
    checkSpace();
  }

  int totalSpace = 0;
  int freeSpace = 0;
  checkSpace() async{
    MethodChannel platform = const MethodChannel('dev.jideguru.filex/storage');
    var free = await platform.invokeMethod("getStorageFreeSpace");
    var total = await platform.invokeMethod("getStorageTotalSpace");
    setFreeSpace(free);
    setTotalSpace(total);
  }

  void setFreeSpace(value) {
    freeSpace = value;
    notifyListeners();
  }

  void setTotalSpace(value) {
    totalSpace = value;
    notifyListeners();
  }
}