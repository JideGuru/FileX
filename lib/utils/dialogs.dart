import 'package:fluttertoast/fluttertoast.dart';

class Dialogs {
  static showToast(value) {
    Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
    );
  }
}
