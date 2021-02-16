import 'package:device_apps/device_apps.dart';
import 'package:filex/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Installed Apps"),
      ),
      body: FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
          onlyAppsWithLaunchIntent: true,
          includeSystemApps: true,
          includeAppIcons: true,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Application> data = snapshot.data;
            // Sort the App List on Alphabetical Order
            data..sort((app1, app2)=>app1.appName.toLowerCase()
                .compareTo(app2.appName.toLowerCase()));
            return ListView.separated(
              padding: EdgeInsets.only(left: 10),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                Application app = data[index];
                return ListTile(
                  leading: app is ApplicationWithIcon
                      ? Image.memory(app.icon, height: 40, width: 40)
                      : null,
                  title: Text(app.appName),
                  subtitle: Text("${app.packageName}"),
                  onTap: () => DeviceApps.openApp(app.packageName),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return CustomDivider();
              },
            );
          }
          return CustomLoader();
        },
      ),
    );
  }
}
