import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:filex/providers/app_provider.dart';
import 'package:filex/providers/category_provider.dart';
import 'package:filex/screens/about.dart';
import 'package:filex/util/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    check();
  }

  int sdkVersion = 0;

  check() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        sdkVersion = androidInfo.version.sdkInt;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.all(0),
            secondary: Icon(
              Feather.eye_off,
            ),
            title: Text(
              "See hidden files",
            ),
            value: Provider.of<CategoryProvider>(context).showHidden,
            onChanged: (value) {
              Provider.of<CategoryProvider>(context, listen: false)
                  .setHidden(value);
            },
            activeColor: Theme.of(context).accentColor,
          ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          MediaQuery.of(context).platformBrightness !=
                  Constants.darkTheme.brightness
              ? SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.all(0),
                  secondary: Icon(
                    Feather.moon,
                  ),
                  title: Text(
                    "Dark mode",
                  ),
                  value: Provider.of<AppProvider>(context).theme ==
                          Constants.lightTheme
                      ? false
                      : true,
                  onChanged: (v) {
                    if (v) {
                      Provider.of<AppProvider>(context, listen: false)
                          .setTheme(Constants.darkTheme, "dark");
                    } else {
                      Provider.of<AppProvider>(context, listen: false)
                          .setTheme(Constants.lightTheme, "light");
                    }
                  },
                  activeColor: Theme.of(context).accentColor,
                )
              : SizedBox(),
          MediaQuery.of(context).platformBrightness !=
                  Constants.darkTheme.brightness
              ? Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                )
              : SizedBox(),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            onTap: () {
              showLicensePage(context: context);
            },
            leading: Icon(
              Feather.file_text,
            ),
            title: Text(
              "Open source licences",
            ),
          ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: About(),
                ),
              );
            },
            leading: Icon(
              Feather.info,
            ),
            title: Text(
              "About",
            ),
          ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}
