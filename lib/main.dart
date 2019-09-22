import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquor_advisor/my_flutter_app_icons.dart';


final db = Firestore.instance;


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int selectedPage = 0;
  String priceValue;
  String nameValue;
  String typeValue;
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
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              child: Icon(Icons.cloud_upload),
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Запись создана'),
                    )
                );
                uploadPressed();
              },
            );
          },
        ),
        body: Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                    onChanged: (price) {
                      priceValue = price;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Цена'
                    )
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                    onChanged: (name) {
                      nameValue = name;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Название'
                    )
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                    onChanged: (type) {
                      typeValue = type;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Тип'
                    )
                ),
              ),
            ),
          ],
        ),
        //pageOptions[selectedPage],
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
                  icon: Icon(MyFlutterApp.emo_beer),
                  title: Text('Очень сильно')
              )
            ]
        ),
      ),
    );
  }

  void uploadPressed() async {
    await db.collection('liquors').add({
      'name': nameValue,
      'effect': selectedPage,
      'type': typeValue,
      'price': priceValue
    });
  }
}


