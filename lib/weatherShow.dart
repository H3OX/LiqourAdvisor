import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'home_page.dart';
import 'weatherRequest.dart';

class weatherOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.all(0.0),
              child: FutureBuilder(
                future: getWeather(),
                initialData: '...',
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return (
                    Padding (
                      padding: EdgeInsets.only(left: 35.0, right: 80.0, top: 10.0),
                        child: ListTile(
                          title: Text('На улице', 
                          style: TextStyle(
                          fontSize: 19.0, 
                          color: Colors.cyanAccent
                        )
                      ),
                      leading: Icon(
                        Icons.wb_sunny, 
                        color: Colors.yellow
                      ),
                      trailing: Text(
                        '${snapshot.data.toString()}°C', 
                        style: TextStyle(
                          fontSize: 20.0, 
                          color: Colors.cyanAccent
                          )
                        ),
                      onTap: () {
                        HomePageState.temp = snapshot.data.toString();
                      }
                    )
                    )
                  );
                },
              )
    );
  }
}