import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class resultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return resultPageState();
  }
}

class resultPageState extends State<resultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты запроса')
      ),
    );
  }
}