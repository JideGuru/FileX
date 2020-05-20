import 'dart:async';
import 'dart:io';

import 'package:filex/widgets/custom_alert.dart';
import 'package:flutter/material.dart';

class IosError extends StatefulWidget {
  @override
  _IosErrorState createState() => _IosErrorState();
}

class _IosErrorState extends State<IosError> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () => showError());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  showError() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "This app only works on Android. Please run on an android device!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () => exit(0),
                  child: Text(
                    "Close app",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
