import 'dart:io';

import 'package:filex/providers/providers.dart';
import 'package:filex/screens/apps_screen.dart';
import 'package:filex/screens/category.dart';
import 'package:filex/screens/downloads.dart';
import 'package:filex/screens/images.dart';
import 'package:filex/screens/search.dart';
import 'package:filex/screens/whatsapp_status.dart';
import 'package:filex/utils/utils.dart';
import 'package:filex/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Browse extends StatelessWidget {
  refresh(BuildContext context) async {
    await Provider.of<CoreProvider>(context, listen: false).checkSpace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${AppStrings.appName}",
          style: TextStyle(fontSize: 25.0),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "Search",
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(themeData: Theme.of(context)),
              );
            },
            icon: Icon(Feather.search),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: ListView(
          padding: EdgeInsets.only(left: 20.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            _SectionTitle('Storage Devices'),
            _StorageSection(),
            CustomDivider(),
            SizedBox(height: 20.0),
            _SectionTitle('Categories'),
            _CategoriesSection(),
            CustomDivider(),
            SizedBox(height: 20.0),
            _SectionTitle('Recent Files'),
            _RecentFiles(),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    );
  }
}

class _StorageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoreProvider>(
      builder: (BuildContext context, coreProvider, Widget child) {
        if (coreProvider.storageLoading) {
          return Container(height: 100, child: CustomLoader());
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: coreProvider.availableStorage.length,
          itemBuilder: (BuildContext context, int index) {
            FileSystemEntity item = coreProvider.availableStorage[index];

            String path = item.path.split("Android")[0];
            double percent = 0;

            if (index == 0) {
              percent = calculatePercent(
                  coreProvider.usedSpace, coreProvider.totalSpace);
            } else {
              percent = calculatePercent(
                  coreProvider.usedSDSpace, coreProvider.totalSDSpace);
            }
            return StorageItem(
              percent: percent,
              path: path,
              title: index == 0 ? "Device" : "SD Card",
              icon: index == 0 ? Feather.smartphone : Icons.sd_storage,
              color: index == 0 ? Colors.lightBlue : Colors.orange,
              usedSpace: index == 0
                  ? coreProvider.usedSpace
                  : coreProvider.usedSDSpace,
              totalSpace: index == 0
                  ? coreProvider.totalSpace
                  : coreProvider.totalSDSpace,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return CustomDivider();
          },
        );
      },
    );
  }

  calculatePercent(int usedSpace, int totalSpace) {
    return double.parse((usedSpace / totalSpace * 100).toStringAsFixed(0)) /
        100;
  }
}

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: Constants.categories.length,
      itemBuilder: (BuildContext context, int index) {
        Map category = Constants.categories[index];

        return ListTile(
          onTap: () {
            if (index == Constants.categories.length - 1) {
              // Check if the user has whatsapp installed
              if (Directory(FileUtils.waPath).existsSync()) {
                Navigate.pushPage(
                  context,
                  WhatsappStatus(title: "${category["title"]}"),
                );
              } else {
                Dialogs.showToast(
                    "Please Install WhatsApp to use this feature");
              }
            } else if (index == 0) {
              Navigate.pushPage(
                  context, Downloads(title: "${category["title"]}"));
            } else if (index == 5) {
              Navigate.pushPage(context, AppScreen());
            } else {
              Navigate.pushPage(
                context,
                index == 1 || index == 2
                    ? Images(title: "${category["title"]}")
                    : Category(title: "${category["title"]}"),
              );
            }
          },
          contentPadding: EdgeInsets.all(0),
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Icon(category["icon"], size: 18, color: category["color"]),
          ),
          title: Text("${category["title"]}"),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider();
      },
    );
  }
}

class _RecentFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoreProvider>(
      builder: (BuildContext context, coreProvider, Widget child) {
        if (coreProvider.recentLoading) {
          return Container(height: 150, child: CustomLoader());
        }
        return ListView.separated(
          padding: EdgeInsets.only(right: 20),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: coreProvider.recentFiles.length > 5
              ? 5
              : coreProvider.recentFiles.length,
          itemBuilder: (BuildContext context, int index) {
            FileSystemEntity file = coreProvider.recentFiles[index];
            return file.existsSync() ? FileItem(file: file) : SizedBox();
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 1,
              color: Theme.of(context).dividerColor,
            );
          },
        );
      },
    );
  }
}
