import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquor_advisor/my_flutter_app_icons.dart';
import 'weatherRequest.dart';

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

  static int isButtonOff = 0;
  static int effect;
  static int age;
  static int weight;
  static int height;
  static String temp;
  final sb = SnackBar(content: Text('Некоторые поля пустые!'));

  
  @override
  Widget build(BuildContext context) {

    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
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
              trailing: Icon(UsefulIcons.coffee_cup),
              onTap: () {
                Navigator.of(context).pop();
                HomePageState.effect = 1;
                HomePageState.isButtonOff = 1;
                print(effect);
              },
            ),
            ListTile(
              title: Text(
                'Немного',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(UsefulIcons.coffee),
              onTap: () {
                Navigator.of(context).pop();
                HomePageState.effect = 2;
                HomePageState.isButtonOff = 1;
                print(effect);
              },
            ),
            ListTile(
              title: Text(
                'Средне',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(UsefulIcons.beer),
              onTap: () {
                Navigator.of(context).pop();
                HomePageState.effect = 3;
                HomePageState.isButtonOff = 1;
                print(effect);
              },
            ),
            ListTile(
              title: Text(
                'Сильно',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(UsefulIcons.wine),
              onTap: () {
                Navigator.of(context).pop();
                HomePageState.effect = 4;
                HomePageState.isButtonOff = 1;
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
                HomePageState.effect = 5;
                HomePageState.isButtonOff = 1;
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
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0.0),
              child: FutureBuilder(
                future: getWeather(),
                initialData: 'Fetch...',
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return (
                    ListTile(
                      trailing: Text('Температура на улице', 
                      style: TextStyle(fontSize: 18.0, color: Colors.cyan)),
                      leading: Icon(Icons.wb_sunny, color: Colors.yellow,),
                      title: Text('${snapshot.data.toString()}°C', style: TextStyle(fontSize: 18.0, color: Colors.cyanAccent)),
                      onTap: () {
                        HomePageState.temp = snapshot.data.toString();
                      }
                    )
                  );
                },
              )
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.solidAngry, color: Colors.cyan),
                labelText: 'Возраст:'
              ),
              keyboardType: TextInputType.phone,
              onFieldSubmitted: (String val) {
                HomePageState.age = int.parse(val);
                print(HomePageState.age);
              },
            ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(FontAwesomeIcons.telegram, color: Colors.cyan),
                  labelText: 'Рост:'
                ),
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (String val) {
                  HomePageState.height = int.parse(val);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(FontAwesomeIcons.smile, color: Colors.cyan),
                  labelText: 'Вес'
                ),
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (String val) {
                  HomePageState.weight = int.parse(val);
                },
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(top: 150.0),
              child: FlatButton(
                child: Text('Подобрать'),
                highlightColor: Colors.cyanAccent,
                onPressed: () {
                  if (isButtonOff == 0) {
                    return null;
                  }
                  else {
                    pageSwitch(context);
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

class resultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return resultPageState();
  }
}

void pageSwitch(context) {
  Navigator.push(context, 
  MaterialPageRoute(builder: (context)  => resultPage()));
}

class resultPageState extends State<resultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты запроса')
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: db.collection('liquors').where('effect', isEqualTo: HomePageState.effect).getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Загрузка...', style: TextStyle(fontSize: 15.0),);
          }
          return ListView(
            children: getRefs(snapshot),
          );
        },
      )
    );
  }
  getRefs(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents.map((snap) => ListTile(title: Text(snap['title']), subtitle: Text(snap['type'])))
    .toList();
  }
}

