import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:liquor_advisor/my_flutter_app_icons.dart';

final db = Firestore.instance;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String imageURI =
      'https://www.irishtimes.com/polopoly_fs/1.3334998.1514975827!/image/image.jpg_gen/derivatives/box_620_330/image.jpg';
  int effect;
  String resTitle = '';
  int resPrice = 0;
  String resType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Подбор алкоголя'),
        backgroundColor: Colors.cyan,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Выберите степень опьянения:'),
              accountEmail: Text('От этого будет зависеть эффект'),
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(imageURI))),
              currentAccountPicture: (GestureDetector(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.sheetlabels.com/resources/mm_files/labels/66877/custom-liquor-bottle-labels.jpg'),
                ),
              )),
            ),
            ListTile(
              title: Text(
                'Слабо',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(MyFlutterApp.coffee_cup),
              onTap: () {
                Navigator.of(context).pop();
                this.effect = 1;
                print(effect);
              },
            ),
            ListTile(
              title: Text(
                'Немного',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(MyFlutterApp.coffee),
              onTap: () {
                Navigator.of(context).pop();
                this.effect = 2;
                print(effect);
              },
            ),
            ListTile(
              title: Text(
                'Средне',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(MyFlutterApp.beer),
              onTap: () {
                Navigator.of(context).pop();
                this.effect = 3;
                print(effect);
              },
            ),
            ListTile(
              title: Text(
                'Сильно',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(MyFlutterApp.wine),
              onTap: () {
                Navigator.of(context).pop();
                this.effect = 4;
                print(effect);
              },
            ),
            ListTile(
              title: Text(
                'Очень сильно',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(Icons.whatshot),
              onTap: () {
                Navigator.of(context).pop();
                this.effect = 5;
                print(effect);
              },
            ),
            ListTile(
              title: Text('Закрыть', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Название:',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                  child: Text(resTitle, style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.all(20.0))
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Цена:',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                  child:
                      Text(resPrice.toString(), style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.all(20.0))
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Тип:',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                  child: Text(resType, style: TextStyle(fontSize: 20)),
                  padding: EdgeInsets.all(20.0))
            ],
          ),
          Expanded(
            child: Container(),
          ),
          FlatButton(
            child: Text('Подобрать'),
            highlightColor: Colors.cyan,
            onPressed: () {
              getData(effect);
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Подбор алкоголя')),
          BottomNavigationBarItem(
              icon: Icon(Icons.map), title: Text('Поиск ближайшего бара'))
        ],
      ),
    );
  }

  getData(lvl) {
    db
        .collection('liquors')
        .where('effect', isEqualTo: lvl)
        .snapshots()
        .listen((data) {
      setState(() {
        this.resTitle = data.documents[0]['title'];
        this.resPrice = data.documents[0]['price'];
        this.resType = data.documents[0]['type'];
      });
    });
  }
}
