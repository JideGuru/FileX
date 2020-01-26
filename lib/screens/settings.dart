import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Settings extends StatelessWidget {
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

          SwitchListTile.adaptive(
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
          ),
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
