import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquor_advisor/my_flutter_app_icons.dart';
import 'weatherRequest.dart';
import 'resultPage.dart';

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
  int age;
  int weight;
  int height;
  String temp;
  final sb = SnackBar(content: Text('Некоторые поля пустые!'));

  var docs = db.collection('liquors');
  
  @override
  Widget build(BuildContext context) {

    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
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
                this.effect = 1;
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
                this.effect = 2;
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
                this.effect = 3;
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
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0.0),
              child: FutureBuilder(
                future: getWeather(),
                initialData: 'Loading...',
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return (
                    ListTile(
                      trailing: Text('Температура на улице', 
                      style: TextStyle(fontSize: 18.0, color: Colors.cyan)),
                      leading: Icon(Icons.wb_sunny, color: Colors.yellow,),
                      title: Text('${snapshot.data.toString()}°C', style: TextStyle(fontSize: 18.0, color: Colors.cyanAccent)),
                      onTap: () {
                        this.temp = snapshot.data.toString();
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
                this.age = int.parse(val);
                print(this.age);
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
                  this.height = int.parse(val);
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
                  this.weight = int.parse(val);
                },
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(top: 150.0),
              child: FlatButton(
                child: Text('Подобрать'),
                highlightColor: Colors.cyanAccent,
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context)  => resultPage())
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}



