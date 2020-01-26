import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class FileItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){},
      contentPadding: EdgeInsets.all(0),
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
      trailing: IconButton(
        onPressed: (){

        },
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).textTheme.title.color,
        ),
      ),
    );
  }
}
