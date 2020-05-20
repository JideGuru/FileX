import 'dart:io';

import 'package:filex/util/consts.dart';
import 'package:filex/util/file_utils.dart';
import 'package:filex/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mime_type/mime_type.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

// ignore: must_be_immutable
class WhatsappStatus extends StatelessWidget {
  final String title;

  WhatsappStatus({
    Key key,
    @required this.title,
  }) : super(key: key);
  List<FileSystemEntity> files = Directory(FileUtils.waPath).listSync()
    ..removeWhere((f) => basename(f.path).split("")[0] == ".");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$title",
        ),
      ),
      body: Directory(FileUtils.waPath).existsSync()
          ? CustomScrollView(
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(10.0),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    crossAxisCount: 2,
                    children: Constants.map(
                      files,
                      (index, item) {
                        FileSystemEntity f = files[index];
                        String path = f.path;
                        File file = File(path);
                        String mimeType = mime(path);
                        return mimeType == null
                            ? SizedBox()
                            : InkWell(
                                onTap: () => OpenFile.open(file.path),
                                child: GridTile(
                                  header: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black54,
                                          Colors.transparent
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              IconButton(
                                                onPressed: () async {
                                                  print("Saving");
                                                  await Directory(
                                                          "/storage/emulated/0/${Constants.appName}")
                                                      .create();
                                                  await Directory(
                                                          "/storage/emulated/0/${Constants.appName}/Whatsapp Status")
                                                      .create();
                                                  await file.copy(
                                                      "/storage/emulated/0/${Constants.appName}/Whatsapp Status/${basename(path)}");
                                                  print("Done");
                                                  Fluttertoast.showToast(
                                                    msg: "Saved!",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    timeInSecForIos: 1,
                                                  );
                                                },
                                                icon: Icon(
                                                  Feather.download,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                              mimeType.split("/")[0] == "video"
                                                  ? Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          "${FileUtils.formatBytes(file.lengthSync(), 1)}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .play_circle_filled,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      "${FileUtils.formatBytes(file.lengthSync(), 1)}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  child: mimeType.split("/")[0] == "video"
                                      ? VideoThumbnail(
                                          path: path,
                                        )
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
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "Please Install and USE Whatsapp to access this page!",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
