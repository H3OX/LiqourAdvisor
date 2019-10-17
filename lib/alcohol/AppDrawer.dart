import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'CustomIcons.dart';

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
            accountEmail: Text('Выберите нужную секцию'),
            decoration: BoxDecoration(),
            currentAccountPicture: (GestureDetector(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn.liquor.com/wp-content/uploads/2017/08/07094756/Why-Your-Favorite-Booze-Bottles-Are-Shaped-the-Way-They-Are-and-Why-You-Should-Care-720x720-article-v21.jpg'),
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
