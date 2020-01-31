import 'dart:io';

import 'package:filex/util/file_utils.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:filex/widgets/sort_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Folder extends StatefulWidget {
  final String title;
  final String path;

  Folder({
    Key key,
    @required this.title,
    @required this.path,
  }): super(key: key);

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  String path;

  List<FileSystemEntity> files = List();

  getFiles() async{
    Directory dir = Directory(path);
    List<FileSystemEntity> l = dir.listSync();
    files.clear();
    setState(() {
      files.addAll(l);
    });
  }
  @override
  void initState() {
    super.initState();
    path = widget.path;
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${widget.title}",
            ),
            Text(
              "$path",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
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
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(left: 20),
        itemCount: files.length,
        itemBuilder: (BuildContext context, int index) {
          return FileItem(
            file: files[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                  width: MediaQuery.of(context).size.width - 70,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Feather.plus),
        tooltip: "Add Folder",
      ),
    );
  }
}
