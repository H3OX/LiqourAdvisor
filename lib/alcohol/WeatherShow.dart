import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'HomePage.dart';
import 'WeatherRequest.dart';

class WeatherOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0.0),
        child: FutureBuilder(
          future: getWeather(),
          initialData: '...',
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return (Padding(
                padding: EdgeInsets.only(left: 35.0, right: 80.0, top: 10.0),
                child: ListTile(
                    title: Text('На улице',
                        style: TextStyle(fontSize: 17.0,
                            color: HomePageState.hexToColor('#EB2188'),
                            fontWeight: FontWeight.w900)),
                    leading: Icon(Icons.wb_sunny,
                        color: HomePageState.hexToColor('#EB2188')),
                    trailing: Text('${snapshot.data.toString()} °C',
                        style: TextStyle(
                            fontSize: 19.0,
                            color: HomePageState.hexToColor('#EB2188'),
                            fontWeight: FontWeight.w900)),
                    onTap: () {
                      HomePageState.temp = snapshot.data.toString();
                    })));
          },
        ));
  }
}
