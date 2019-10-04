import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ButtonsPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ButtonsPanelState();
  }
}

class ButtonsPanelState extends State<ButtonsPanel> {
  Color color;
  Color femaleColor;
  Color maleColor;

  @override
  void initState() {
    super.initState();
    color = Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
              child: FlatButton(
              color: maleColor,
                child: Text(
                  'Мужчина',
                  style: TextStyle(
                  fontSize: 17.0
                ),
              ),
              onPressed: () {
                setState(() {
                  this.maleColor = Colors.cyan;
                  this.femaleColor = Colors.grey;
              });
            },
          )
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: FlatButton(
              color: femaleColor,
              child: Text(
                'Женщина',
                style: TextStyle(
                fontSize: 17.0
                ),
              ),
              onPressed: () {
                setState(() {
                  this.femaleColor = Colors.pink;
                  this.maleColor = Colors.grey;
              });
          },
        )
        )
        ],
      ),
    );
    
  }
}