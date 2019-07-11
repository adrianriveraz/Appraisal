import 'package:flutter/material.dart';
import 'package:appraisal_project/screens/login/logindef.dart';
import 'package:appraisal_project/auth.dart';

//Form Object defined
LForm _newLogin = new LForm();

//create enum for form type
enum FormType { login, register }

//create form Widget
class Login extends StatefulWidget {
  Login({this.auth, this.onSignedIn}); //pass auth instance to create Login page
  //Login({this.auth});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginState createState() => new _LoginState();
}

//create State class to hold form data
class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FormType _formType = FormType.login;

  @override
  // create form
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: Text('Login'),
        ),
        body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
            key: _formKey,
            autovalidate: true, //validate form as data is entered
            child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: buildInputs() + buildButtons()),
          ),
        ));
  }

//build form
  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.email),
          labelText: 'Email',
        ),
        validator: (val) => val.isEmpty ? 'Email is required' : null,
        onSaved: (val) => _newLogin.email = val,
      ),
      new TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.lock),
          labelText: 'Password',
        ),
        obscureText: true,
        validator: (val) => val.isEmpty ? 'Password is required' : null,
        onSaved: (val) => _newLogin.password = val,
      ),
    ];
  }

//build buttons
  List<Widget> buildButtons() {
    if (_formType == FormType.login) {
      return [
        new Container(
            padding: const EdgeInsets.only(left: 40.0),
            child: new RaisedButton(
              child: new Text('Login', style: new TextStyle(fontSize: 20)),
              onPressed: () => _submitForm(),
            )),
        new Container(
            padding: const EdgeInsets.only(left: 40.0),
            child: new FlatButton(
              child: new Text('Create an account',
                  style: new TextStyle(fontSize: 20)),
              onPressed: () => moveToRegister(),
            )),
      ];
    } else {
      return [
        new Container(
            padding: const EdgeInsets.only(left: 40.0),
            child: new RaisedButton(
              child: new Text('Create an account',
                  style: new TextStyle(fontSize: 20)),
              onPressed: () => _submitForm(),
            )),
        new Container(
            padding: const EdgeInsets.only(left: 40.0),
            child: new FlatButton(
              child: new Text('Have an account? Login',
                  style: new TextStyle(fontSize: 20)),
              onPressed: () => moveToLogin(),
            )),
      ];
    }
  }

//show message at bottom of screen if try to submit in invalid form
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

//validate the form, save data for now just print the passed values
  bool valSave() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
      return false;
    } else {
      form.save(); //Invoke each onSaved event

      print('Form is up to date...');
      print('Email: ${_newLogin.email}');
      print('Pword: ${_newLogin.password}');
      return true;
    }
  }

//submit form and authenticate data with firebase; maybe store hash of pass
  void _submitForm() async {
    if (valSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth
              .signInWithEmailAndPassword(_newLogin.email, _newLogin.password);
          print('Signed in: $userId');
        } else {
          String userId = await widget.auth.createUserWithEmailAndPassword(
              _newLogin.email, _newLogin.password);
          print('Signed in: $userId');
        }
        //print('Skkkkkkkkkkkkkkkkkkkk');
        //print(widget.toString());
        widget.onSignedIn();
        //print('Soooooouttt');
      } catch (e) {
        print('Error: , $e');
      }
    }
  }

  void moveToRegister() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }
}
