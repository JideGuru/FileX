import 'package:flutter/material.dart';

class FilePopup extends StatelessWidget {
  final String path;

  FilePopup({
    Key key,
    @required this.path,
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
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
    );
  }
}
