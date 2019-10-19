import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'HomePage.dart';

class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  GoogleMapController mapController;

  final LatLng _center =
      LatLng(HomePageState.latlng.latitude, HomePageState.latlng.longitude);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: GradientAppBar(
            title: Text('Найти бар'),
            backgroundColorStart: HomePageState.hexToColor('#080A52'),
            backgroundColorEnd: HomePageState.hexToColor('#080A52')),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
