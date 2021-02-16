import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Constants {
  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static List categories = [
    {
      "title": "Downloads",
      "icon": Feather.download,
      "path": "",
      "color": Colors.purple
    },
    {
      "title": "Images",
      "icon": Feather.image,
      "path": "",
      "color": Colors.blue
    },
    {"title": "Videos", "icon": Feather.video, "path": "", "color": Colors.red},
    {
      "title": "Audio",
      "icon": Feather.headphones,
      "path": "",
      "color": Colors.teal
    },
    {
      "title": "Documents & Others",
      "icon": Feather.file,
      "path": "",
      "color": Colors.pink
    },
    {"title": "Apps", "icon": Icons.android, "path": "", "color": Colors.green},
    {
      "title": "Whatsapp Statuses",
      "icon": FontAwesome.whatsapp,
      "path": "",
      "color": Colors.green
    },
  ];

  static List sortList = [
    "File name (A to Z)",
    "File name (Z to A)",
    "Date (oldest first)",
    "Date (newest first)",
    "Size (largest first)",
    "Size (Smallest first)",
  ];
}
