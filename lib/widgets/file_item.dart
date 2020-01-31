import 'dart:io';

import 'package:filex/util/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

class FileItem extends StatelessWidget {
  final FileSystemEntity file;

  FileItem({
    Key key,
    @required this.file,
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=>OpenFile.open(file.path),
      contentPadding: EdgeInsets.all(0),
      leading: FutureBuilder<Widget>(
        future: FileUtils.setFileIcon(file == null?"":file.path),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot==null
              ? SizedBox()
              : snapshot.hasData
              ? snapshot.data
              : SizedBox();
        },
      ),
      title: Text(
        "${basename(file.path)}",
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        "${FileUtils.formatBytes(file == null?678476:File(file.path).lengthSync(), 2)},"
            " ${file == null?"Test":FileUtils.formatTime(File(file.path).lastModifiedSync().toIso8601String())}",
      ),
      trailing: PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              "Rename",
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: Text(
              "Delete",
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              "Copy to",
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              "Move to",
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              "Share",
            ),
          ),
        ],
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).textTheme.title.color,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        offset: Offset(0, 30),
      ),
    );
  }
}
