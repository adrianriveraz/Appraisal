import 'package:flutter/material.dart';

//create App Form button, when pressed goes to form page
class GoAppFormButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        " Create Apprasial Form ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/appForm');
      },
    );
  }
}
