import 'package:flutter/material.dart';
import 'home_page.dart';


void main() => runApp(MyApp());

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
            primarySwatch: Colors.blue,
            brightness: Brightness.dark
        ),
        home: HomePage()
    );
  }
}
