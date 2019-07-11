import 'package:appraisal_project/root.dart';
import 'package:appraisal_project/screens/form/form.dart';
import 'package:flutter/material.dart';
import 'package:appraisal_project/screens/home/home.dart';
// import 'package:appraisal_project/screens/login/login.dart';
import 'package:appraisal_project/auth.dart';
import 'package:appraisal_project/screens/captureMedia.dart';
import 'package:appraisal_project/screens/dynamic_listview.dart';

//generate routes for navagation
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //get passed in arguments
    //final args = settings.arguments;

    switch (settings.name) {
      case '/': //login page
        return MaterialPageRoute(builder: (_) => RootPage(auth: new Auth()));
      //return MaterialPageRoute(builder: (_) => RootPage(auth: ,));

      case '/home': //home page
        return MaterialPageRoute(builder: (_) => Home());

      case '/appForm': //form page
        //add type validation later
        return MaterialPageRoute(builder: (_) => AppForm());

      case '/mediaCapture': //form page
        //add type validation later
        return MaterialPageRoute(builder: (_) => CaptureMedia());

      case '/vieweditforms': //form page
        //add type validation later
        return MaterialPageRoute(builder: (_) => DynamicListViewScreen());

      default: //otherwise navigate to error page
        return _errorRoute();
    }
  }

  //define error page
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text("ERROR"),
        ),
      );
    });
  }
}
