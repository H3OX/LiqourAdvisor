import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'ResultPage.dart';


class GoogleWebView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoogleWebViewState();
  }
}

class GoogleWebViewState extends State<GoogleWebView> {

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://www.google.com/search?q=${ResultPageState.queryName}',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}