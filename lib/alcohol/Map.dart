import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'HomePage.dart';
import 'MapRequest.dart';

class Maps extends StatefulWidget {
  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
  GoogleMapController mapController;
  var places = [];
  static const apiKey = 'AIzaSyCBCJiTOqQtCIO_D7jtLmy2uGPV7ULdqV8';
  static String requestString = 'https://maps.googleapis.com/maps/api/place/textsearch/json?query=%D0%B1%D0%BB%D0%B8%D0%B6%D0%B0%D0%B9%D1%88%D0%B8%D0%B9+%D0%B1%D0%B0%D1%80&key=${apiKey}';
  static Set<Marker> markers = Set();

  final LatLng _center =
      LatLng(HomePageState.latlng.latitude, HomePageState.latlng.longitude);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    markers.add(
      Marker(
        markerId: MarkerId('newyork'),
        position: LatLng(37.3962412, 55.7849502),
      ),
    );
    mapRequest();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: GradientAppBar(
            title: Text('Найти бар'),
            backgroundColorStart: HomePageState.hexToColor('#080A52'),
            backgroundColorEnd: HomePageState.hexToColor('#080A52')),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              markers: markers,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

