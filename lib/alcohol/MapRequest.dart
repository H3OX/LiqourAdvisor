import 'HomePage.dart';
import 'Map.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//needed to iterate over response['geometry']['location']

Future<dynamic> mapRequest() async {
  var req = await http.get('https://maps.googleapis.com/maps/api/place/textsearch/json?query=%D0%B1%D0%BB%D0%B8%D0%B6%D0%B0%D0%B9%D1%88%D0%B8%D0%B9+%D0%B1%D0%B0%D1%80&key=AIzaSyCBCJiTOqQtCIO_D7jtLmy2uGPV7ULdqV8');
  Map<String, dynamic> response = json.decode(req.body);
  List<dynamic> results = response['results'];
  Map<String, dynamic> obj;
}
