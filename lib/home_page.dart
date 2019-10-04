import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'AppDrawer.dart';
import 'weatherShow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'my_flutter_app_icons.dart';
import 'ButtonPanel.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'UniquePage.dart';

//Database init
final db = Firestore.instance;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  //Necessary variables for in-app interaction
  var scaffoldKey = GlobalKey<ScaffoldState>();
  static int isButtonOff = 0;
  static int effect;
  static int age;
  static int sex;
  static int weight;
  static int height;
  static String temp;
  static String type;
  static double bmi;
  var requestParams;
  static String url = 'https://alcoml-engine.herokuapp.com/';
  static String responsefromAPI = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Подбор алкоголя'),
        backgroundColor: Colors.cyan,
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Column(
          children: <Widget>[
            WeatherOut(),
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
                    isButtonOff = 7;
                    return null;
                  }
                  return null;
                },
                onFieldSubmitted: (String val) {
                  if (int.parse(val) >= 1 && int.parse(val) <= 4) {
                    isButtonOff++;
                    effect = int.parse(val);
                  }
                  print(isButtonOff);
                },
              ),
              )
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonsPanel()
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
                    HomePageState.sex = ButtonsPanelState.sex;
                    var convertedHeight = height/100;
                    bmi = weight/(pow(convertedHeight, 2));
                    requestParams = [sex, age, bmi];
                    var request = await http.post(
                      url, 
                      body: json.encode(
                        {
                      'params': requestParams
                    })
                    );
                    print(requestParams);
                    setState(() {
                     responsefromAPI = request.body; 
                    });
                    print(responsefromAPI);
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
      )
    );
  }
}