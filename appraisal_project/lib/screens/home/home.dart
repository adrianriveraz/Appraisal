import 'package:flutter/material.dart';
// import 'package:appraisal_project/screens/home/widgets/goappform_button.dart';
import 'package:appraisal_project/screens/home/widgets/gocapturemedia_button.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Apprasial App'),
        ),
        body: Center(
          child: CaptureMediaButton()
        ),
      );
  }
}