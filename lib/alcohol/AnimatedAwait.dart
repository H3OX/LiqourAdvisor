import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'HomePage.dart';

class AnimatedAwait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
            title: Text('Подбор алкоголя'),
            backgroundColorStart: HomePageState.hexToColor('#000428'),
            backgroundColorEnd: HomePageState.hexToColor('#004e92')),
        body: Container(
          child: SpinKitWave(color: Colors.cyan, size: 50.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                HomePageState.hexToColor('#000428'),
                HomePageState.hexToColor('#004e92')
              ]))
        )
    );
  }
}