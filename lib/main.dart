import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'alcohol/HomePage.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((x) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LiquorAdvisor',
        theme: ThemeData(
            primarySwatch: Colors.lime,
            accentColor: HomePageState.hexToColor('#EB2188'),
            brightness: Brightness.dark,
            fontFamily: 'Montserrat'
        ),
        home: Container(child: HomePage()));
  }
}
