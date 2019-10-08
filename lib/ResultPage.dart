import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_flutter_app_icons.dart';
import 'WebViewPage.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class ResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResultPageState();
  }
}

class ResultPageState extends State<ResultPage> {
  static String queryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Подбор алкоголя'),
        backgroundColorStart: Colors.blue,
        backgroundColorEnd: Colors.red
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red]
          )
        ),
        child: FutureBuilder<QuerySnapshot>(

        future: db.collection('test2')
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
      )
    );
  }

  getResults(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents.map(
      (snap) => ListTile(
      title: Text(snap['title']), 
      subtitle: Text('Потребуется ${((HomePageState.preferredAmount/(double.parse(snap['alc'].toString().replaceAll(',', '.'))/100))*500).toStringAsFixed(0)}мл. Цена за объем: ${(((((HomePageState.preferredAmount/(double.parse(snap['alc'].toString().replaceAll(',', '.'))/100))*500))/snap['vol']) * snap['price']).toStringAsFixed(0)}₽'),
      trailing: Icon(UsefulIcons.wine),
      onTap: () {
        ResultPageState.queryName = snap['title'];
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)  => GoogleWebView())); 
      },
      )
    ).toList();
  } 
}