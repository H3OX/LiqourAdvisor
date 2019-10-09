import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ButtonsPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ButtonsPanelState();
  }
}

class ButtonsPanelState extends State<ButtonsPanel> {
  Color femaleColor = Colors.grey[700];
  Color maleColor = Colors.grey[700];
  static int sex;

  @override
  void initState() {
    super.initState();
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
                  style: TextStyle(fontSize: 17.0),
                ),
                onPressed: () {
                  setState(() {
                    this.maleColor = Colors.indigo;
                    this.femaleColor = Colors.grey[700];
                    ButtonsPanelState.sex = 0;
                  });
                },
              )),
          Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: FlatButton(
                color: femaleColor,
                child: Text(
                  'Женщина',
                  style: TextStyle(fontSize: 17.0),
                ),
                onPressed: () {
                  setState(() {
                    this.femaleColor = Colors.pinkAccent;
                    this.maleColor = Colors.grey[700];
                    ButtonsPanelState.sex = 0;
                  });
                },
              ))
        ],
      ),
    );
  }
}
