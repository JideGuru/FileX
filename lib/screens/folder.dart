import 'package:filex/widgets/file_item.dart';
import 'package:filex/widgets/sort_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Folder extends StatelessWidget {
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
              "Internal Storage",
            ),
            Text(
              "/storage/emulated/0/Flutter Ebook App/The_Sea_Wolf.epub",
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return FileItem();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 1,
            color: Theme.of(context).dividerColor,
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
