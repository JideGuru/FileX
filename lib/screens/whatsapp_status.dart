import 'dart:io';

import 'package:filex/utils/utils.dart';
import 'package:filex/widgets/video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
      appBar: AppBar(title: Text("$title")),
      body: CustomScrollView(
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
                      : _WhatsAppItem(
                          file: file, path: path, mimeType: mimeType);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WhatsAppItem extends StatelessWidget {
  final File file;
  final String path;
  final String mimeType;

  _WhatsAppItem({this.file, this.path, this.mimeType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => OpenFile.open(file.path),
      child: GridTile(
        header: Container(
          height: 50.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black54, Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () => saveMedia(),
                    icon: Icon(
                      Feather.download,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ),
                  mimeType.split("/")[0] == "video"
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "${FileUtils.formatBytes(file.lengthSync(), 1)}",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                            SizedBox(width: 5.0),
                            Icon(
                              Icons.play_circle_filled,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ],
                        )
                      : Text(
                          "${FileUtils.formatBytes(file.lengthSync(), 1)}",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        child: mimeType.split("/")[0] == "video"
            ? VideoThumbnail(path: path)
            : Image(
          fit: BoxFit.cover,
          errorBuilder: (b, o, c) {
            return Icon(Icons.image);
          },
          image: ResizeImage(
            FileImage(File(file.path)),
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }

  saveMedia() async {
    String rootPath = '/storage/emulated/0/';
    await Directory("$rootPath${AppStrings.appName}").create();
    await Directory("$rootPath${AppStrings.appName}/Whatsapp Status").create();
    await file.copy(
        "$rootPath${AppStrings.appName}/Whatsapp Status/${basename(path)}");
    Dialogs.showToast("Saved!");
  }
}
