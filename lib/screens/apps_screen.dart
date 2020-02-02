import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Installed Apps",
        ),
      ),

      body: FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
          onlyAppsWithLaunchIntent: true,
          includeSystemApps: true,
          includeAppIcons: true,
        ),
        builder: (context, snapshot) {
          return snapshot == null
              ? Center(
            child: CircularProgressIndicator(),
          )
              : snapshot.hasData
              ? ListView.separated(
            padding: EdgeInsets.only(left: 10),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Application app = snapshot.data[index];
              return ListTile(
                leading: app is ApplicationWithIcon
                    ? Image.memory(
                  app.icon,
                  height: 40,
                  width: 40,
                )
                    : null,
                title: Text(
                  app.appName,
                ),
                subtitle: Text(
                  "${app.packageName}"
                ),
                onTap: ()=>DeviceApps.openApp(app.packageName),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 1,
                      color: Theme.of(context).dividerColor,
                      width: MediaQuery.of(context).size.width - 80,
                    ),
                  ),
                ],
              );
            },
          ): Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }
}
