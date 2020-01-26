import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Constants{

  //App related strings
  static String appName = "FileX";


  //Colors for theme
  static Color lightPrimary = Color(0xfff3f4f9);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xff597ef7);
  static Color darkAccent = Color(0xff597ef7);
  static Color lightBG = Color(0xfff3f4f9);
  static Color darkBG = Colors.black;

  static ThemeData lightTheme = ThemeData(
//    fontFamily: "TimesNewRoman",
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
//          fontFamily: "TimesNewRoman",
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
//    fontFamily: "TimesNewRoman",
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
//          fontFamily: "TimesNewRoman",
          color: lightBG,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );


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
    {
      "title": "Videos",
      "icon": Feather.video,
      "path": "",
      "color": Colors.red
    },
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
    {
      "title": "Apps",
      "icon": Icons.android,
      "path": "",
      "color": Colors.green
    },
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
    "Date (newest first)",
    "Date (oldest first)",
    "Size (largest first)",
    "Size (Smallest first)",
  ];
}