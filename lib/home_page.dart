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
import 'MLResponseFetch.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


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
  static bool isAgeEntered  = false;
  static bool isHeightEntered = false;
  static bool isWeightEntered = false;
  static bool isEffectEntered = false;
  bool isSubmitButtonActive = false;
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
  static double preferredAmount;
  FocusNode focus1;
  FocusNode focus2;
  FocusNode focus3;

  @override
  void initState() {
    super.initState();
    this.focus1 = FocusNode();
    this.focus2 = FocusNode();
    this.focus3 = FocusNode();
  }

  @override
  void dispose() {
    this.focus1.dispose();
    this.focus2.dispose();
    this.focus3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawerScrimColor: Colors.blue,
      appBar: GradientAppBar(
        title: Text('Подбор алкоголя'),
        backgroundColorStart: Colors.blue,
        backgroundColorEnd: Colors.red
      ),
      drawer: AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red]
          )
        ),
        child: Column(
          children: <Widget>[
            WeatherOut(),
            Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
              child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Возраст:',
                icon: Icon(
                  FontAwesomeIcons.python, 
                  color: Colors.cyan
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autofocus: true,
              onFieldSubmitted: (val) {
                age = int.parse(val);
                isAgeEntered = true;
                FocusScope.of(context).requestFocus(focus1);
                print(isAgeEntered);
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
                textInputAction: TextInputAction.next,
                focusNode: focus1,
                onFieldSubmitted: (String val) {
                  height = int.parse(val);
                  isHeightEntered = true;
                  FocusScope.of(context).requestFocus(focus2);
                  print(isHeightEntered);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 50.0, right: 50.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Вес',
                  icon: Icon(
                    FontAwesomeIcons.weight, 
                    color: Colors.cyan
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)
                    )
                ),
                keyboardType: TextInputType.phone,
                focusNode: focus2,
                onFieldSubmitted: (String val) {
                  weight = int.parse(val);
                  isWeightEntered = true;
                  FocusScope.of(context).requestFocus(focus3);
                  print(isWeightEntered);
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
                focusNode: focus3,
                validator: (val) {
                  if (!(int.parse(val) >= 1 && int.parse(val) <= 4)) {
                    isEffectEntered = false;
                    return null;
                  }
                  return null;
                },
                onFieldSubmitted: (String val) {
                  if (int.parse(val) >= 1 && int.parse(val) <= 4) {
                    isEffectEntered = true;
                    effect = int.parse(val);
                    isSubmitButtonActive = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    print(isSubmitButtonActive);
                  }
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
                  if (!isSubmitButtonActive) {
                    return null;
                  }
                  if (isSubmitButtonActive && isEffectEntered && isWeightEntered && isHeightEntered && isAgeEntered) {
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
                    setState(() {
                     responsefromAPI = request.body; 
                     HomePageState.preferredAmount = double.parse(processResponse(HomePageState.responsefromAPI).toStringAsFixed(2));
                    });
                    
                    print('Preferred amount -> ${HomePageState.preferredAmount}');
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