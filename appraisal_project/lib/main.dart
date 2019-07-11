import 'package:flutter/material.dart';
import 'package:appraisal_project/routes.dart';
// import 'package:appraisal_project/auth.dart';
// import 'package:appraisal_project/screens/login/login.dart';

void main() => runApp(MyApp());

//set up homepage as initial route, Do NOT add other Material Apps
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Appraisal App',
      //home:new Login(auth: new Auth()));
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
