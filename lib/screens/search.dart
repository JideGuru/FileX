import 'dart:io';

import 'package:filex/providers/providers.dart';
import 'package:filex/screens/folder/folder.dart';
import 'package:filex/utils/utils.dart';
import 'package:filex/widgets/dir_item.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  final ThemeData themeData;

  Search({
    Key key,
    @required this.themeData,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = themeData;
    assert(theme != null);
    return theme.copyWith(
      primaryTextTheme: theme.primaryTextTheme,
      textTheme: theme.textTheme.copyWith(
        headline1: theme.textTheme.headline1.copyWith(
          color: theme.primaryTextTheme.headline6.color,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: theme.primaryTextTheme.headline6.color,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<FileSystemEntity>>(
      future: FileUtils.searchFiles(query,
          showHidden:
              Provider.of<CategoryProvider>(context, listen: false).showHidden),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot == null
            ? SizedBox()
            : snapshot.hasData
                ? snapshot.data.isEmpty
                    ? Center(
                        child: Text("No file match your query!"),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.only(left: 20),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          FileSystemEntity file = snapshot.data[index];
                          return file.toString().split(":")[0] == "Directory"
                              ? DirectoryItem(
                                  popTap: null,
                                  file: file,
                                  tap: () {
                                    Navigate.pushPage(
                                      context,
                                      Folder(title: "Storage", path: file.path),
                                    );
                                  },
                                )
                              : FileItem(
                                  file: file,
                                  popTap: null,
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
                      )
                : SizedBox();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<FileSystemEntity>>(
      future: FileUtils.searchFiles(query,
          showHidden:
              Provider.of<CategoryProvider>(context, listen: false).showHidden),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot == null
            ? SizedBox()
            : snapshot.hasData
                ? snapshot.data.isEmpty
                    ? Center(
                        child: Text("No file match your query!"),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.only(left: 20),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          FileSystemEntity file = snapshot.data[index];
                          return file.toString().split(":")[0] == "Directory"
                              ? DirectoryItem(
                                  popTap: null,
                                  file: file,
                                  tap: () {
                                    Navigate.pushPage(
                                      context,
                                      Folder(title: "Storage", path: file.path),
                                    );
                                  },
                                )
                              : FileItem(
                                  file: file,
                                  popTap: null,
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
                      )
                : SizedBox();
      },
    );
  }
}
