import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
    //  title: 'Welcome to Flutter',
    //  home: Scaffold(
      return Scaffold(
        appBar: AppBar(
          title: Text('Appraisal Form'),
        ),
        body: Center(
          child: Text('Form Goes Here'),
        ),
      );
    
  }
}