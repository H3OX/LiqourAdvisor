import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              padding: EdgeInsets.only(right: 15.0, top: 5.0),
              child: FlatButton(
                shape: StadiumBorder(),
                color: maleColor,
                child: Text(
                  'Мужчина',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w900),
                ),
                onPressed: () {
                  setState(() {
                    this.maleColor = Colors.indigoAccent;
                    this.femaleColor = Colors.grey[700];
                    ButtonsPanelState.sex = 0;
                  });
                },
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, top: 5.0),
              child: FlatButton(
                shape: StadiumBorder(),
                color: femaleColor,
                child: Text(
                  'Женщина',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w900),
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
