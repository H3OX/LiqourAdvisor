import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'my_flutter_app_icons.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppDrawerState();
  }
}

class AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Главное меню', style: TextStyle(fontSize: 20.0)),
              accountEmail: Text(''),
              decoration: BoxDecoration(
                
                  ),
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
      );
  }
}