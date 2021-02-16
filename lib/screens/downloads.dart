import 'package:filex/providers/providers.dart';
import 'package:filex/utils/utils.dart';
import 'package:filex/widgets/custom_divider.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class Downloads extends StatefulWidget {
  final String title;

  Downloads({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).getDownloads();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CategoryProvider provider, Widget child) {
        return DefaultTabController(
          length: provider.downloadTabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text("${widget.title}"),
              bottom: TabBar(
                indicatorColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).accentColor,
                unselectedLabelColor: Theme.of(context).textTheme.caption.color,
                isScrollable: false,
                tabs: Constants.map<Widget>(
                  provider.downloadTabs,
                  (index, label) {
                    return Tab(text: "$label");
                  },
                ),
              ),
            ),
            body: Visibility(
              visible: provider.downloads.isNotEmpty,
              replacement: Center(child: Text("No Files Found")),
              child: TabBarView(
                children: Constants.map<Widget>(
                  provider.downloadTabs,
                  (index, label) {
                    return ListView.separated(
                      padding: EdgeInsets.only(left: 20),
                      itemCount: provider.downloads.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FileItem(file: provider.downloads[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return CustomDivider();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
