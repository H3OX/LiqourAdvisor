import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'HomePage.dart';

String apiKey = '7da57778334a1b3fe7e5990a67e0d167';

LocationData location;
var loc = new Location();

Future<dynamic> getWeather() async {
  var userLoc = await loc.getLocation();
  print(userLoc.longitude);
  print(userLoc.latitude);
  HomePageState.latlng = userLoc;
  String url =
      'https://api.darksky.net/forecast/$apiKey/${userLoc.latitude},${userLoc.longitude}?units=si';
  var response = await http.get(url);
  Map<String, dynamic> res = json.decode(response.body);
  return (res['currently']['temperature']);
}
