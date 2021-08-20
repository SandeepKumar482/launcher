import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BouncingScrollPhysics _bouncingScrollPhysics = BouncingScrollPhysics();
  DateTime now = new DateTime.now();

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("H:m a").format(now);
  }

  String getSystemDay() {
    var now = new DateTime.now();
    return new DateFormat("EEEE").format(now);
  }

  String getSystemDate() {
    var now = new DateTime.now();
    return new DateFormat("d MMM yyyy").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future(() => false),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/wallpape.gif'), fit: BoxFit.cover)),
          child: PageView(
            children: [
              FutureBuilder(
                  future: DeviceApps.getInstalledApplications(
                      includeSystemApps: true,
                      includeAppIcons: true,
                      onlyAppsWithLaunchIntent: true),
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<Application> allHomeApps =
                          snapshot.data as List<Application>;
                      List<Application> homeApps = [];
                      for (int i = 0; i < allHomeApps.length; i++) {
                        if (allHomeApps[i].appName == 'Phone') {
                          homeApps.add(allHomeApps[i]);
                        }
                        if (allHomeApps[i].appName == 'Messages') {
                          homeApps.add(allHomeApps[i]);
                        }
                        if (allHomeApps[i].appName == 'Contacts') {
                          homeApps.add(allHomeApps[i]);
                        }
                        if (allHomeApps[i].appName == 'Camera') {
                          homeApps.add(allHomeApps[i]);
                        }
                      }
                      return SafeArea(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: TimerBuilder.periodic(
                                          Duration(seconds: 1),
                                          builder: (context) {
                                        // print(
                                        //     "${DateFormat('h:mm:ss a').format(now)}");
                                        return Text(
                                          "${getSystemTime()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontFamily: ('Ribeye'),
                                              fontWeight: FontWeight.w700),
                                        );
                                      }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Container(
                                        child: Text(
                                          '${getSystemDay()}',
                                          style: TextStyle(
                                              fontSize: 47,
                                              color: Colors.white,
                                              fontFamily: ('Ribeye')),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Container(
                                        child: Text(
                                          '${getSystemDate()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontFamily: ('Ribeye')),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children:
                                    List.generate(homeApps.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      DeviceApps.openApp(
                                          homeApps[index].packageName);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Image.memory(
                                            (homeApps[index]
                                                    as ApplicationWithIcon)
                                                .icon,
                                            width: 32,
                                          ),
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          Text(
                                            "${homeApps[index].appName}",
                                            style:
                                                TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Container(
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    );
                  }),
              FutureBuilder(
                  future: DeviceApps.getInstalledApplications(
                      includeAppIcons: true,
                      includeSystemApps: true,
                      onlyAppsWithLaunchIntent: true),
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<Application> allApps =
                          snapshot.data as List<Application>;
                      allApps.sort((a, b) => a.appName.compareTo(b.appName));
                      return GridView.count(
                        crossAxisCount: 3,
                        physics: _bouncingScrollPhysics,
                        padding: EdgeInsets.only(top: 60.0),
                        children: List.generate(allApps.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              DeviceApps.openApp(allApps[index].packageName);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Image.memory(
                                    (allApps[index] as ApplicationWithIcon)
                                        .icon,
                                    width: 32,
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    "${allApps[index].appName}",
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    }
                    return Container(
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
