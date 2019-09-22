import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton.icon(
            onPressed: null,
            icon: Icon(Icons.cloud_upload),
            label: Text('Submit')),
      ),
    );
  }
}
