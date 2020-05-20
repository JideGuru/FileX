import 'dart:io';

import 'package:filex/providers/category_provider.dart';
import 'package:filex/util/consts.dart';
import 'package:filex/util/file_utils.dart';
import 'package:filex/widgets/file_icon.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class Images extends StatelessWidget {
  final String title;

  Images({
    Key key,
    @required this.title,
  }) : super(key: key);

//  @override
//  void initState() {
//    super.initState();
//    Timer(Duration(milliseconds: 1), (){
//      if(widget.title.toLowerCase() == "images"){
//        Provider.of<CategoryProvider>(context, listen: false).getImages("image");
//      }else{
//        Provider.of<CategoryProvider>(context, listen: false).getImages("video");
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CategoryProvider provider, Widget child) {
        return provider.loading
            ? Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : DefaultTabController(
                length: provider.imageTabs.length,
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
                          provider.imageTabs.length < 3 ? false : true,
                      tabs: Constants.map<Widget>(
                        provider.imageTabs,
                        (index, label) {
                          return Tab(
                            text: "$label",
                          );
                        },
                      ),
                    ),
                  ),
                  body: provider.images.isEmpty
                      ? Center(child: Text("No Files Found"))
                      : TabBarView(
                          children: Constants.map<Widget>(
                            provider.imageTabs,
                            (index, label) {
                              List l = List();
                              List items = provider.images;
                              items.forEach((file) {
                                if ("${file.path.split("/")[file.path.split("/").length - 2]}" ==
                                    label) {
                                  l.add(file);
                                }
                              });
                              return CustomScrollView(
                                primary: false,
                                slivers: <Widget>[
                                  SliverPadding(
                                    padding: EdgeInsets.all(10.0),
                                    sliver: SliverGrid.count(
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0,
                                      crossAxisCount: 2,
                                      children: Constants.map(
                                        index == 0
                                            ? provider.images
                                            : l.reversed.toList(),
                                        (index, item) {
                                          File file = File(item.path);
                                          String path = file.path;
                                          String mimeType = mime(path);
                                          return InkWell(
                                            onTap: () =>
                                                OpenFile.open(file.path),
                                            child: GridTile(
                                              header: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black54,
                                                        Colors.transparent
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: mimeType.split(
                                                                "/")[0] ==
                                                            "video"
                                                        ? Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Text(
                                                                "${FileUtils.formatBytes(file.lengthSync(), 1)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .play_circle_filled,
                                                                color: Colors
                                                                    .white,
                                                                size: 16,
                                                              ),
                                                            ],
                                                          )
                                                        : Text(
                                                            "${FileUtils.formatBytes(file.lengthSync(), 1)}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              child: mimeType.split("/")[0] ==
                                                      "video"
                                                  ? FileIcon(file: file)
                                                  : Image.file(
                                                      File(path),
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
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
