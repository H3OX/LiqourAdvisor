import 'HomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

double processResponse(String MLResponse) {
  if (HomePageState.effect == 1) {
    return (double.parse(MLResponse) / 4);
  } else if (HomePageState.effect == 2) {
    return (double.parse(MLResponse) / 2);
  } else if (HomePageState.effect == 3) {
    return (double.parse(MLResponse) * 0.75);
  } else {
    if (MLResponse.contains('\n')) {
      return double.parse(MLResponse.replaceAll('\n', ''));
    } else {
      return double.parse(MLResponse);
    }
  }
}

Future setParams(params) async {
  var request = await http.post('https://alcoml-engine.herokuapp.com/',
      body: json.encode({'params': params}));
  var res = request.body;
  return double.parse(
      processResponse(res).toStringAsFixed(2));
}
