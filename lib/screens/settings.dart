import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
  check() async{
    if(Platform.isAndroid){
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
            value: false,
            onChanged: (v){

            },
          ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),

          sdkVersion<28?SwitchListTile.adaptive(
            contentPadding: EdgeInsets.all(0),
            secondary: Icon(
              Feather.moon,
            ),
            title: Text(
              "Dark mode",
            ),
            value: false,
            onChanged: (v){

            },
          ):SizedBox(),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),

          ListTile(
            contentPadding: EdgeInsets.all(0),
            onTap: (){
              showLicensePage(context: context);
            },
            leading: Icon(
              Feather.file_text,
            ),
            title: Text(
              "Licences",
            ),
          ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),

          ListTile(
            contentPadding: EdgeInsets.all(0),
            onTap: (){},
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
