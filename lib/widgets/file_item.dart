import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mime_type/mime_type.dart';

class FileItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        File file = File("/storage/emulated/0/Flutter Ebook App/The_Sea_Wolf.epub");
        String mimeType = mime(file.path);
        print(mimeType);
      },
      contentPadding: EdgeInsets.all(0),
//      leading: FutureBuilder<Widget>(
//        future: FileUtils.setFileIcon("/storage/emulated/0/Telegram/Telegram Video/4_5827829871128085955.mp4"),
//        builder: (BuildContext context, AsyncSnapshot snapshot) {
//          return snapshot==null
//              ? SizedBox()
//              : snapshot.hasData
//              ? snapshot.data
//              : SizedBox();
//        },
//      ),
      leading: Container(
        height: 40,
        width: 40,
        child: Center(
          child: Icon(
            Feather.file,
            color: Colors.lightBlue,
          ),
        ),
      ),
      title: Text("Final project"),
      subtitle: Text(
          "1MB, Yesterday"
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
