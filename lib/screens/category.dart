import 'dart:io';

import 'package:filex/providers/providers.dart';
import 'package:filex/utils/utils.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:filex/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  final String title;

  Category({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      switch (widget.title.toLowerCase()) {
        case 'audio':
          Provider.of<CategoryProvider>(context, listen: false)
              .getAudios('audio');
          break;
        case 'documents & others':
          Provider.of<CategoryProvider>(context, listen: false)
              .getAudios('text');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CategoryProvider provider, Widget child) {
        return provider.loading
            ? Scaffold(body: CustomLoader())
            : DefaultTabController(
                length: provider.audioTabs.length,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("${widget.title}"),
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
                          return Tab(text: "$label");
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
                              List l = [];
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
                                  return FileItem(file: file);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return CustomDivider();
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
