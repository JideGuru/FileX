import 'dart:io';

import 'package:filex/utils/utils.dart';
import 'package:filex/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddFileDialog extends StatelessWidget {
  final String path;

  AddFileDialog({this.path});

  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 15),
            Text(
              "Add New Folder",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 25),
            TextField(
              controller: name,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 130,
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 40,
                  width: 130,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (name.text.isNotEmpty) {
                        if (!Directory(path + "/${name.text}").existsSync()) {
                          await Directory(path + "/${name.text}")
                              .create()
                              .catchError((e) {
                            print(e.toString());
                            if (e.toString().contains("Permission denied")) {
                              Dialogs.showToast(
                                  "Cannot write to this Storage  device!");
                            }
                          });
                        } else {
                          Dialogs.showToast(
                              "A Folder with that name already exists!");
                        }
                        Navigator.pop(context);
                      }
                    },
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
