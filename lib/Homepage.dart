import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BouncingScrollPhysics _bouncingScrollPhysics = BouncingScrollPhysics();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[350],
        child: FutureBuilder(
            future: DeviceApps.getInstalledApplications(
              includeSystemApps: true,
              onlyAppsWithLaunchIntent: true,
              includeAppIcons: true,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<Application>? apps = snapshot.data as List<Application>?;
                return GridView.count(
                    crossAxisCount: 2,
                    physics: _bouncingScrollPhysics,
                    padding: EdgeInsets.only(top: 60.0),
                    children: List.generate(apps!.length, (index) {
                      return InkWell(
                        onTap: () {
                          DeviceApps.openApp(apps[index].packageName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  DeviceApps.openApp(apps[index].packageName);
                                },
                                child: Image.memory(
                                  (apps[index] as ApplicationWithIcon).icon,
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                "${apps[index].appName}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }));
              }
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}
