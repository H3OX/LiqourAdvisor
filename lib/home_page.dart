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
import 'weatherShow.dart';

//Database init
final db = Firestore.instance;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var sliderValue = 0.0;
  String imageURI =
      'https://www.irishtimes.com/polopoly_fs/1.3334998.1514975827!/image/image.jpg_gen/derivatives/box_620_330/image.jpg';

//Necessary variables for in-app interaction
  static int isButtonOff = 0;
  static int effect;
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
  final TextEditingController controller = new TextEditingController();
  Color femaleColor = Colors.grey;
  Color maleColor = Colors.grey;




  @override
  Widget build(BuildContext context) {

    var scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              accountEmail: Text(''),
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
            weatherOut(),
          
            Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
              child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Возраст:',
                icon: Icon(
                  FontAwesomeIcons.cannabis, 
                  color: Colors.cyan
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
              ),
              keyboardType: TextInputType.phone,
              onChanged: (val) {
                age = int.parse(val);
                isButtonOff++;
                print(isButtonOff);
              },
            ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 50.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Рост(см):',
                  icon: Icon(
                    FontAwesomeIcons.textHeight, 
                    color: Colors.cyan
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)
                    )
                ),
                keyboardType: TextInputType.phone,
                onChanged: (String val) {
                  height = int.parse(val);
                  isButtonOff++;
                  print(isButtonOff);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 50.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Вес',
                  icon: Icon(
                    FontAwesomeIcons.smile, 
                    color: Colors.cyan
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)
                    )
                ),
                keyboardType: TextInputType.phone,
                onChanged: (String val) {
                  weight = int.parse(val);
                  isButtonOff++;
                  print(isButtonOff);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 50.0),
              child: Form(
                key: formKey,
                child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Степень опьянения от 1 до 4',
                  icon: Icon(
                    UsefulIcons.beer, 
                    color: Colors.cyan
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)
                    )
                ),
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (!(int.parse(val) >= 1 && int.parse(val) <= 4)) {
                    isButtonOff = 3;
                    return null;
                  }
                  return null;
                },
                onFieldSubmitted: (String val) {
                  if (int.parse(val) >= 1 && int.parse(val) <= 4) {
                    HomePageState.isButtonOff++;
                    HomePageState.effect = int.parse(val);
                  }
                  print(HomePageState.isButtonOff);
                },
              ),
              )
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
                      setState(() {
                       maleColor = Colors.cyan; 
                       femaleColor = Colors.grey;
                      });
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Выбран пол: Мужчина'),
                        )
                      );
                      HomePageState.sex = 0;
                      print(sex);
                    },
                    color: maleColor,
                  ),
                  FlatButton(
                    child: Text('Женщина', 
                    style: TextStyle(
                      fontSize: 17.0
                    )
                    ),
                    highlightColor: Colors.cyanAccent,
                    onPressed: () {
                      setState(() {
                       femaleColor = Colors.pink; 
                       maleColor = Colors.grey;
                      });
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Выбран пол: Женщина'),
                        )
                      );
                      HomePageState.sex = 1;
                      print(sex);
                    },
                    color: femaleColor,
                  ),
                  
                ]
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: FlatButton(
                child: Text('Подобрать', style: TextStyle(fontSize: 15.0)),
                highlightColor: Colors.indigoAccent,
                color: Colors.purple,
                onPressed: () async {
                  if (isButtonOff < 8) {
                    return null;
                  }
                  if (isButtonOff == 8) {
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
                    scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text(responsefromAPI),
                        ));
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context)  => UniquePage()
                        )
                      );
                  }
                  else {
                    return null;
                  }
                }
              ),
            )
          ],
        ),
      
        
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

/* 
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
            */