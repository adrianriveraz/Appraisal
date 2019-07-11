import 'package:flutter/material.dart';

//create App Form button, when pressed goes to form page
class GoCaptureMediaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Record Media"),
      onPressed: () {
        Navigator.of(context).pushNamed('/mediaCapture');
      },
    );
  }
}
