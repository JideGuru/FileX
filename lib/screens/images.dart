import 'dart:io';

import 'package:filex/util/consts.dart';
import 'package:filex/util/file_utils.dart';
import 'package:filex/widgets/sort_sheet.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';

class Images extends StatelessWidget {
  final String title;

  Images({
    Key key,
    @required this.title,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    List tabs = [
      "All",
      "Downloads"
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "$title",
          ),
          actions: <Widget>[
            IconButton(
              onPressed: (){
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SortSheet(),
                );
              },
              tooltip: "Sort by",
              icon: Icon(
                Icons.sort,
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Theme.of(context).accentColor,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).textTheme.caption.color,
            isScrollable: true,
            tabs: Constants.map<Widget>(
              tabs,
                  (index, label){
                return Tab(
                  text: "$label",
                );
              },
            ),
          ),
        ),

        body: TabBarView(
          children: Constants.map<Widget>(
            tabs,
                (index, label){
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
                        List.generate(11, (v)=>"j"),
                        (index, item){
                          String path = "/storage/emulated/0/Telegram/Telegram Images/264411626_241952.jpg";
                          String mimeType = mime(path);
                          return GridTile(
                            header: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black54,
                                    Colors.transparent
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: mimeType.split("/")[0] == "video"
                                      ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "${FileUtils.formatBytes(20971520, 1)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Icon(
                                        Icons.play_circle_filled,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  )
                                      :Text(
                                    "${FileUtils.formatBytes(20971520, 1)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: mimeType.split("/")[0] == "video"
                                ? FutureBuilder(
                              future: FileUtils.getVideoThumbnail(path),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                return snapshot == null
                                    ? SizedBox()
                                    : snapshot.hasData
                                    ? Image.file(
                                    File(snapshot.data),
                                  fit: BoxFit.cover,
                                )
                                    : SizedBox();
                              },
                            )
                                : Image.file(
                              File(path),
                              fit: BoxFit.cover,
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
  }
}
