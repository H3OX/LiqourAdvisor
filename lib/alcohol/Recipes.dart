import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:liquor_advisor/alcohol/Cocktail.dart';
import 'package:liquor_advisor/alcohol/CustomIcons.dart';
import 'HomePage.dart';

class Recipes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecipesState();
  }
}

class RecipesState extends State<Recipes> {
  static String name;
  static List ingredients;
  static String preparation;
  static String i = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
              title: Text('Подбор алкоголя'),
              backgroundColorStart: HomePageState.hexToColor('#080A52'),
              backgroundColorEnd: HomePageState.hexToColor('#080A52')),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HomePageState.hexToColor('#080A52'),
                  HomePageState.hexToColor('#080A52')
                ])
        ),
        child: FutureBuilder(
          future: db
          .collection('cocktails')
          .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SpinKitWave(color: Colors.cyan, size: 50.0);
            }
            return ListView(
              children: getRecipes(snapshot),
            );
          },
        ),
      )
    );
  }
  getRecipes(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((snap) => ListTile(
      title: Text(snap['name']),
      subtitle: Text(snap['category']),
      trailing: Icon(UsefulIcons.wine),
      onTap: () {
        RecipesState.name = snap['name'];
        RecipesState.ingredients = snap['ingredients'];
        RecipesState.preparation = snap['preparation'];
        i = extract(RecipesState.ingredients);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => Cocktail())
        );
      },
    )
    ).toList();
  }

  String extract(List lst) {
    String sb = '';
    for (var x in lst) {
      if (x.containsKey('ingredient') || x.containsKey('amount')) {
        print('added ${x['ingredient']}');
        sb += '${x['ingredient']}: ${x['amount']}CL \n';
      }
    }
    return sb;
  }
}