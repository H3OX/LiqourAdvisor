import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'ResultPage.dart';

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
        .where('clr', isLessThanOrEqualTo: HomePageState.preferredAmount)
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