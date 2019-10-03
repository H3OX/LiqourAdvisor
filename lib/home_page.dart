import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquor_advisor/my_flutter_app_icons.dart';
import 'weatherRequest.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Database init
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

//Necessary variables for in-app interaction
  static int isButtonOff = 0;
  static int effect = 0;
  static int age;
  static int weight;
  static int height;
  static String temp;
  static String type;
  static double bmi;
  static int sex;
  var requestParams;
  static String url = 'https://alcoml-engine.herokuapp.com/';
  static String responsefromAPI = '';
  int curIndex = 0;


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
              accountName: Text('Главное меню', style: TextStyle(fontSize: 20.0)),
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
                'Алкоголь',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(UsefulIcons.wine),
              onTap: () {
                Navigator.of(context).pop();
                print(effect);
              },
            ),
            ListTile(
              title: Text(
                'Найти ближайший бар',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: Icon(UsefulIcons.beer),
              onTap: () {
                Navigator.of(context).pop();
                print(effect);
              },
            ),
            ListTile(
              title: Text('Кальянные', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.code),
              subtitle: Text('В разработке...'),
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
                      style: TextStyle(fontSize: 18.0, 
                      color: Colors.cyan
                        )
                      ),
                      leading: Icon(
                        Icons.wb_sunny, 
                        color: Colors.yellow
                      ),
                      title: Text(
                        '${snapshot.data.toString()}°C', 
                        style: TextStyle(
                          fontSize: 18.0, 
                          color: Colors.cyanAccent
                          )
                        ),
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
                labelText: 'Возраст:',
                icon: Icon(
                  FontAwesomeIcons.solidAngry, 
                  color: Colors.cyan
                  ),        
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
                  labelText: 'Рост:',
                  icon: Icon(
                    FontAwesomeIcons.telegram, 
                    color: Colors.cyan
                    ),
                ),
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (String val) {
                  HomePageState.height = int.parse(val);
                  print(HomePageState.height);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Вес',
                  icon: Icon(
                    FontAwesomeIcons.smile, 
                    color: Colors.cyan
                    ),
                ),
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (String val) {
                  HomePageState.weight = int.parse(val);
                  print(HomePageState.weight);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text('Мужчина',
                    style: TextStyle(
                      fontSize: 17.0
                    ),

                    ),
                    highlightColor: Colors.cyanAccent,
                    onPressed: () {
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Выбран пол: Мужчина'),
                        )
                      );
                      HomePageState.sex = 0;
                      print(sex);
                    }
                  ),
                  FlatButton(
                    child: Text('Женщина', style: TextStyle(
                      fontSize: 17.0
                    )
                    ),
                    highlightColor: Colors.cyanAccent,
                    onPressed: () {
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Выбран пол: Женщина'),
                        )
                      );
                      HomePageState.sex = 1;
                      print(sex);
                    }
                  )
                ]
              )
            
            ),
            Container(
              margin: EdgeInsets.only(top: 100.0),
              child: FlatButton(
                child: Text('Подобрать', style: TextStyle(fontSize: 20.0)),
                highlightColor: Colors.cyanAccent,
                onPressed: () async {
                  if (isButtonOff == 0) {
                    return null;
                  }
                  else {
                    var convertedHeight = height/100;
                    HomePageState.bmi = HomePageState.weight/(pow(convertedHeight, 2));
                    requestParams = [sex, age, bmi];
                    var request = await http.post(
                      HomePageState.url, 
                      body: json.encode(
                        {
                      'params': requestParams
                    })
                    );
                    setState(() {
                     HomePageState.responsefromAPI = request.body; 
                    }); 
                    print(responsefromAPI);                   

                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context)  => UniquePage()
                        )
                      );
                  }
                }
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(UsefulIcons.coffee_cup),
            title: Text('Слабо')
          ),
          BottomNavigationBarItem(
            icon: Icon(UsefulIcons.coffee),
            title: Text('Средне')
          ),
          BottomNavigationBarItem(
            icon: Icon(UsefulIcons.emo_beer),
            title: Text('Сильно')
          ),
          BottomNavigationBarItem(
            icon: Icon(UsefulIcons.wine),
            title: Text('Оч. Сильно')
          )
        ],
        onTap: (int index) {
          setState(() {
            curIndex = index;
          });
        }
      ),
    );
  }
  onTabTapped(int index) {
   setState(() {
     index = index;
   });
 }
}


class UniquePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UniquePageState();
  }
}


class UniquePageState extends State<UniquePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Доступно по вашему запросу:')
      ),
      body: FutureBuilder<QuerySnapshot>(

        future: db.collection('liquors')
        .where('effect', isEqualTo: HomePageState.effect)
        .getDocuments(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SpinKitWave(
              color: Colors.cyan,
              size: 50.0
            );
          }
          return ListView(
            children: getReferences(snapshot),
          );
        },
      )
    );
  }

  

//This method returns unique liquor types from Firestore
  getReferences(AsyncSnapshot<QuerySnapshot> snapshot) {

    //Add only property 'type' from all documents to temporary list
    var tempList = [];
    for (var x in snapshot.data.documents) {
      tempList.add(x.data['type']);
    }
    //Creating a new list containing unique values from temporary list
    var unique = tempList.toSet().toList();

    //Returning ListTiles consisting of unique liquor types
    return unique.map(
      (snap) => ListTile(
      title: Text('${snap[0].toUpperCase()}${snap.substring(1)}'), 
      trailing: Icon(Icons.zoom_in),
      onTap: () {
        HomePageState.type = snap;
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)  => ResultPage()));
      },
      )
    ).toList();
  }
}

class ResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResultPageState();
  }
}

class ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Просмотр результатов'),
      ),
      body: FutureBuilder<QuerySnapshot>(

        future: db.collection('liquors')
        .where('type', isEqualTo: HomePageState.type)
        .getDocuments(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SpinKitWave(
              color: Colors.cyan,
              size: 50.0
            );
          }
          return ListView(
            children: getResults(snapshot),
          );
        },
      ),
    );
  }

  getResults(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents.map(
      (snap) => ListTile(
      title: Text(snap['title']), 
      subtitle: Text('${snap['type'][0].toUpperCase()}${snap['type'].substring(1)}'),
      trailing: Icon(UsefulIcons.wine),
      )
    ).toList();
  }


  
}

