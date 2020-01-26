import 'dart:io';

import 'package:filex/screens/category.dart';
import 'package:filex/util/consts.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Browse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${Constants.appName}",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(
              Feather.search,
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20),
        children: <Widget>[
          Container(
            height: 150,
            padding: EdgeInsets.only(right: 20),
            child: Card(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 10.0,
                      animation: true,
                      animationDuration: 3000,
                      percent: 0.7,
                      reverse: true,
                      center: Text(
                        "70%",
                        style:
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.orangeAccent,
                      backgroundColor: Colors.white,
                    ),

                    SizedBox(width: 30,),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Internal Storage",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 10,),
                        Text(
                          "13Gb / 32Gb",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),

          Text(
            "Categories".toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Constants.categories.length,
            itemBuilder: (BuildContext context, int index) {
              Map category = Constants.categories[index];

              return ListTile(
                onTap: () async{
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Category(),
                    ),
                  );
                },
                contentPadding: EdgeInsets.all(0),
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    category["icon"],
                    size: 18,
                    color: category["color"],
                  ),
                ),
                title: Text(
                  "${category["title"]}",
                ),
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
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 1,
              color: Theme.of(context).dividerColor,
              width: MediaQuery.of(context).size.width - 70,
            ),
          ),


          SizedBox(height: 20,),

          Text(
            "Recent Files".toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),

          ListView.separated(
            padding: EdgeInsets.only(right: 20),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
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
        ],
      ),
    );
  }
}
