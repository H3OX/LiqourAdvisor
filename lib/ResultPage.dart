import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_flutter_app_icons.dart';

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