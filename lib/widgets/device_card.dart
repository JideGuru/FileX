//              Container(
//                height: 150,
//                padding: EdgeInsets.only(right: 20),
//                child: Card(
//                  color: Theme.of(context).accentColor,
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(20),
//                    ),
//                  ),
//                  elevation: 4,
//                  child: Container(
//                    child: Material(
//                      color: Colors.transparent,
//                      child: InkWell(
//                        borderRadius: BorderRadius.all(
//                          Radius.circular(20),
//                        ),
//                        onTap: (){
//                          Navigator.push(
//                            context,
//                            PageTransition(
//                              type: PageTransitionType.rightToLeft,
//                              child: Folder(),
//                            ),
//                          );
//                        },
//                        child: Padding(
//                          padding: EdgeInsets.symmetric(horizontal: 20),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              coreProvider.freeSpace == 0 || coreProvider.totalSpace == 0
//                                  ? CircularProgressIndicator(
//                                valueColor: AlwaysStoppedAnimation((Colors.white)),
//                              )
//                                  : CircularPercentIndicator(
//                                radius: 80.0,
//                                lineWidth: 6.0,
//                                animation: true,
//                                animationDuration: 2000,
//                                percent: percent ?? 0.1,
//                                reverse: true,
//                                center: Text(
//                                  "${(coreProvider.usedSpace / coreProvider.totalSpace * 100)
//                                      .toStringAsFixed(0)}%",
//                                  style:
//                                  TextStyle(
//                                    fontWeight: FontWeight.bold,
//                                    fontSize: 14.0,
//                                    color: Colors.white,
//                                  ),
//                                ),
//                                circularStrokeCap: CircularStrokeCap.round,
//                                progressColor: Colors.orangeAccent,
//                                backgroundColor: Colors.white,
//                              ),
//
//                              SizedBox(width: 30,),
//
//                              Column(
//                                mainAxisSize: MainAxisSize.min,
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  Text(
//                                    "Internal Storage",
//                                    style: TextStyle(
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 18.0,
//                                      color: Colors.white,
//                                    ),
//                                  ),
//
//                                  SizedBox(height: 10,),
//
//                                  Text(
//                                    "${FileUtils.formatBytes(coreProvider.usedSpace, 1)} "
//                                        "/ ${FileUtils.formatBytes(coreProvider.totalSpace, 1)}",
//                                    style: TextStyle(
//                                      fontWeight: FontWeight.w400,
//                                      fontSize: 14.0,
//                                      color: Colors.white,
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ),