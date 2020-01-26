import 'package:filex/widgets/file_item.dart';
import 'package:filex/widgets/sort_sheet.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Downloads",
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              showModalBottomSheet(
                context: context,
                builder: (context) => SortSheet(),
              );
            },
            icon: Icon(
              Icons.sort,
            ),
          ),
        ],
      ),

      body: ListView.separated(
        padding: EdgeInsets.only(left: 20),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {

          return FileItem();
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
    );
  }
}
