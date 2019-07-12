import 'package:flutter/material.dart';

//create App Form button, when pressed goes to form page
class GoSearchAppFormButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Search Apprasial Forms"),
      onPressed: () {
        Navigator.of(context).pushNamed('/searchforms');
      },
    );
  }
}
