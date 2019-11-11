import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:nice_button/nice_button.dart';
import 'Recipes.dart';
import 'HomePage.dart';
import 'web2.dart';

class Cocktail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CocktailState();
  }
}

class CocktailState extends State<Cocktail> {
  static String uri = 'https://www.google.com/search?q=${RecipesState.name}&tbm=isch';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(RecipesState.name, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0),),
          ),
          ListTile(
            title: Text(RecipesState.preparation),
          ),
          ListTile(
            title: Text('Ingredients: ${RecipesState.i}'),
          ),
          NiceButton(
            radius: 40,
            padding: EdgeInsets.all(14),
            text: "Search in Google",
            icon: Icons.search,
            gradientColors: [
              HomePageState.hexToColor('#c33764'),
              HomePageState.hexToColor('#1D2671')
            ],
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GoogleWebView2()));
            },
          )
        ],
        ),
      ),
    );
  }
}