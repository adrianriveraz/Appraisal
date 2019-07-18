import 'package:appraisal_project/auth.dart';
import 'package:flutter/material.dart';
import 'package:appraisal_project/screens/home/widgets/golistforms_button.dart';

class Home extends StatelessWidget {
  Home({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Apprasial App'), actions: <Widget>[
        new FlatButton(
            // padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
            child: new Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => _signOut())
      ]),
      body: Center(child: buildCol(context)),

    );
  }
}

Widget buildCol(context) =>
    // #docregion Row
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text(
            "   Create Apprasial Form   ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/appForm');
          },
        ),
        GoListFormsButton()
      ],
    );
