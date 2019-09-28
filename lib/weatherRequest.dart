import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> getWeather() async {
  String url = 'https://api.darksky.net/forecast/7da57778334a1b3fe7e5990a67e0d167/37.8267,-122.4233?units=si';
  var response = await http.get(url);
  Map<String, dynamic> res = json.decode(response.body);
  return (res['currently']['temperature']);
}