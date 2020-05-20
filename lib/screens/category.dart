import 'dart:io';

import 'package:filex/providers/category_provider.dart';
import 'package:filex/util/consts.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  final String title;

  Category({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CategoryProvider provider, Widget child) {
        return provider.loading
            ? Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : DefaultTabController(
                length: provider.audioTabs.length,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "$title",
                    ),
                    bottom: TabBar(
                      indicatorColor: Theme.of(context).accentColor,
                      labelColor: Theme.of(context).accentColor,
                      unselectedLabelColor:
                          Theme.of(context).textTheme.caption.color,
                      isScrollable:
                          provider.audioTabs.length < 3 ? false : true,
                      tabs: Constants.map<Widget>(
                        provider.audioTabs,
                        (index, label) {
                          return Tab(
                            text: "$label",
                          );
                        },
                      ),
                    ),
                  ),
                  body: provider.audio.isEmpty
                      ? Center(child: Text("No Files Found"))
                      : TabBarView(
                          children: Constants.map<Widget>(
                            provider.audioTabs,
                            (index, label) {
                              List l = List();
                              List items = provider.audio;
                              items.forEach((file) {
                                if ("${file.path.split("/")[file.path.split("/").length - 2]}" ==
                                    label) {
                                  l.add(file);
                                }
                              });
                              return ListView.separated(
                                padding: EdgeInsets.only(left: 20),
                                itemCount: index == 0
                                    ? provider.audio.length
                                    : l.length,
                                itemBuilder:
                                    (BuildContext context, int indexx) {
                                  FileSystemEntity file = index == 0
                                      ? provider.audio[indexx]
                                      : l[indexx];
                                  return FileItem(
                                    file: file,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          height: 1,
                                          color: Theme.of(context).dividerColor,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              70,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                ),
              );
      },
    );
  }
}
