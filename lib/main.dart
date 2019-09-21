import 'package:flutter/material.dart';
import 'package:liquor_advisor/my_flutter_app_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int selectedPage = 0;
  final pageOptions = [
    Text('Пригубить', style: TextStyle(fontSize: 50.0)),
    Text('Бухнуть слегонца', style: TextStyle(fontSize: 50.0)),
    Text('Выпить средне', style: TextStyle(fontSize: 50.0)),
    Text('Напиться сильно', style: TextStyle(fontSize: 50.0)),
    Text('Нажраться', style: TextStyle(fontSize: 50.0))
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Подбор алкогольного напитка'),
        ),
        body: pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (int index) {
            setState(() {
              selectedPage = index;
            });
        },
          items: [
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.coffee),
              title: Text('Чутка')
            ),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.coffee_cup),
              title: Text('Немного')
            ),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.beer),
              title: Text('Средне')
            ),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.wine),
              title: Text('Сильно')
            ),
            BottomNavigationBarItem(
              icon:Icon(MyFlutterApp.emo_beer),
              title: Text('Очень сильно')
            )
          ]
        ),
      ),
    );
  }
}


