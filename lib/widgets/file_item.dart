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
        maxLines: 2,
      ),
      subtitle: file.toString().split(":")[0] != "Directory"
          ?Text(
        "${FileUtils.formatBytes(file == null?678476:File(file.path).lengthSync(), 2)},"
            " ${file == null?"Test":FileUtils.formatTime(File(file.path).lastAccessedSync().toIso8601String())}",
      ):Text("Folder"),
    );
  }
}
