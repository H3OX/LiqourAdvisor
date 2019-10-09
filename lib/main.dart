import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter/services.dart';


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
        title: 'LiquorAdvisor',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            brightness: Brightness.dark,
            canvasColor: Colors.transparent
        ),
        home: Container(
          child: HomePage()
        )
    );
  }
}

