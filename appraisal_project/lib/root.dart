import 'package:flutter/material.dart';
import 'package:appraisal_project/auth.dart';
import 'package:appraisal_project/screens/login/login.dart';

class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;

  @override
    State<StatefulWidget> createState() => new _RootPageState();
    //return null;
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage>{
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  
  @override //called when stateful widget created
  initState(){
    super.initState();
    //check status of current user
    widget.auth.currentUser().then((userId){
      setState(() {
        //_authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  

  void _signedIn(){
    //print("PPPPPP");
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }


  @override
  Widget build(BuildContext context){
    print(_authStatus);
    switch(_authStatus){
      case AuthStatus.notSignedIn:
        return new Login(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        print(_authStatus);
        return new Scaffold(
          body: new Container(
          child: new Text('Welcome'),
        )
        );
    }
    
  }



}