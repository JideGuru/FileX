import 'dart:io';

import 'package:filex/widgets/dir_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';

class DirectoryItem extends StatelessWidget {
  final FileSystemEntity file;
  final Function tap;
  final Function popTap;

  DirectoryItem({
    Key key,
    @required this.file,
    @required this.tap,
    @required this.popTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        height: 40,
        width: 40,
        child: Center(
          child: Icon(
            Feather.folder,
          ),
        ),
      ),
      title: Text(
        "${basename(file.path)}",
        style: TextStyle(
          fontSize: 14,
        ),
        maxLines: 2,
      ),
      trailing:
          popTap == null ? null : DirPopup(path: file.path, popTap: popTap),
    );
  }
}
