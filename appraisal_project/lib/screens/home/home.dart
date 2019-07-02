import 'package:appraisal_project/auth.dart';
import 'package:flutter/material.dart';
import 'package:appraisal_project/screens/home/widgets/goappform_button.dart';
import 'package:appraisal_project/auth.dart';
import 'package:appraisal_project/screens/home/widgets/gocapturemedia_button.dart';

class Home extends StatelessWidget {
  Home({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
 
 void _signOut() async{
   try{
     await auth.signOut();
     onSignedOut();
   }catch(e){
     print(e);
   }
 }



  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: Text('Apprasial App'),
          actions:<Widget>[
            new FlatButton(
              child: new Text("Logout"),
              onPressed: () =>_signOut()
            )
          ]
        ),
        body: Center(
          child: GoAppFormButton()
          //child: CaptureMediaButton()
        ),
      );
  }
}