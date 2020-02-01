import 'package:flutter/material.dart';

class FTPScreen extends StatefulWidget {
  @override
  _FTPScreenState createState() => _FTPScreenState();
}

class _FTPScreenState extends State<FTPScreen> {

  start() async{

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "FTP File Sharing",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.print,
            ),
            onPressed: (){
              start();
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[

        ],
      ),
    );
  }
}
