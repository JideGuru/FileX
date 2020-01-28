import 'package:filex/util/consts.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:filex/widgets/sort_sheet.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String title;

  Category({
    Key key,
    @required this.title,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    List tabs = [
      "All",
      "Downloads"
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "$title",
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
          bottom: TabBar(
            indicatorColor: Theme.of(context).accentColor,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).textTheme.caption.color,
            isScrollable: true,
            tabs: Constants.map<Widget>(
              tabs,
                  (index, label){
                return Tab(
                  text: "$label",
                );
              },
            ),
          ),
        ),

        body: TabBarView(
          children: Constants.map<Widget>(
            tabs,
                (index, label){
              return ListView.separated(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
