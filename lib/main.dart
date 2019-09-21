import 'package:flutter/material.dart';

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
    Text('Item1', style: TextStyle(fontSize: 50.0)),
    Text('Item2', style: TextStyle(fontSize: 36.0)),
    Text('Item3', style: TextStyle(fontSize: 36.0)),
    Text('Item4', style: TextStyle(fontSize: 36.0)),
    Text('Item5', style: TextStyle(fontSize: 36.0))
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('NavBar'),
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
              icon: Icon(Icons.keyboard_arrow_left),
              title: Text('Чутка')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_arrow_right),
              title: Text('Немного')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_arrow_down),
              title: Text('Средне')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_arrow_up),
              title: Text('Сильно')
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.keyboard_return),
              title: Text('Очень сильно')
            )
          ]
        ),
      ),
    );
  }
}


