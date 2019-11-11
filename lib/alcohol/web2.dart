import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Cocktail.dart';

class GoogleWebView2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoogleWebViewState2();
  }
}

class GoogleWebViewState2 extends State<GoogleWebView2> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl:
      'https://www.google.com/search?q=${CocktailState.uri}',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
