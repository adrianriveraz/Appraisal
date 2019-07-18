import 'package:appraisal_project/screens/form/datamodel/appraisal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../captureMedia.dart';
import 'package:flutter/material.dart';
import 'package:appraisal_project/screens/form/formdef.dart';
import 'package:appraisal_project/service/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

// List for dropdown menu field states
List<String> _ustates = <String>[
  'AL',
  'AK',
  'AZ',
  'AR',
  'CA',
  'CO',
  'CT',
  'DE',
  'FL',
  'GA',
  'HI',
  'ID',
  'IL',
  'IN',
  'IA',
  'KS',
  'KY',
  'LA',
  'ME',
  'MD',
  'MA',
  'MI',
  'MN',
  'MS',
  'MO',
  'MT',
  'NE',
  'NV',
  'NH',
  'NJ',
  'NM',
  'NY',
  'NC',
  'ND',
  'OH',
  'OK',
  'OR',
  'PA',
  'RI',
  'SC',
  'SD',
  'TN',
  'TX',
  'UT',
  'VT',
  'VA',
  'WA',
  'WV',
  'WI',
  'WY'
];
String _ustate = null;

//Form Object defined
ApForm _newForm = new ApForm();
Appraisal _note =
    new Appraisal('a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a');

//create form Widget
class AppForm extends StatefulWidget {
  Appraisal note;
  // NoteScreen(this.note);
  @override
  _AppFormState createState() => new _AppFormState();
  AppForm({Key key, this.mediaSaved}) : super(key: key);

  final List<String> mediaSaved;
}

//create State class to hold form data
class _AppFormState extends State<AppForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> inMediaAttached = List<String>();
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  //copy recieved media array into local array it can be updated with new media
  @override
  void initState() {
    super.initState();
    var len;
    if (widget.mediaSaved.isEmpty) {
      len = 0;
    } else {
      len = widget.mediaSaved.length;
      print(len);
    }

    for (var k = 0; k < len; k++) {
      var n = widget.mediaSaved[k];
      inMediaAttached.add(n);
    }
  }

  @override
  // create form
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: Text('New Appraisal Form'),
        ),
        body: new SafeArea(
            top: false,
            bottom: false,
            child: new Form(
              key: _formKey,
              autovalidate: true, //validate form as data is entered
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Property Address',
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Property Address is required' : null,
                    onSaved: (val) => _newForm.paddress = val,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'City',
                    ),
                    validator: (val) => val.isEmpty ? 'City is required' : null,
                    onSaved: (val) => _newForm.city = val,
                  ),

                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'State',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _ustate == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton<String>(
                            value: _ustate,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _newForm.state = newValue;
                                _ustate = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _ustates.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    validator: (val) {
                      return val != '' ? null : 'Please select a State';
                    },
                    onSaved: (val) => _newForm.state = val,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Zip Code',
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Zip Code is required' : null,
                    onSaved: (val) => _newForm.zip = val,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Borrower',
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Borrower is required' : null,
                    onSaved: (val) => _newForm.borrower = val,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Owner of Public Record',
                    ),
                    validator: (val) => val.isEmpty
                        ? 'Owner of Public Record is required'
                        : null,
                    onSaved: (val) => _newForm.opubrec = val,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'County',
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'County is required' : null,
                    onSaved: (val) => _newForm.county = val,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Legal Description',
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Legal Description is required' : null,
                    onSaved: (val) => _newForm.legaldes = val,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Assessor Parcel Number',
                    ),
                    validator: (val) => val.isEmpty
                        ? 'Assessor Parcel Number is required'
                        : null,
                    onSaved: (val) => _newForm.apnum = val,
                  ),
                  //validator: (val) => val.isEmpty ? 'Assessor Parcel Number is required' : null,
                  //onSaved: (val) => _newForm.apnum = val,
                  //),

                  //new Center(
                  // child: CaptureMediaButton()
                  //),
                  new Container(
                    padding:
                        const EdgeInsets.only(left: 110, right: 110, top: 5.0),
                    child: RaisedButton(
                      child: Text(
                        'Record Media',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _awaitReturnValueFromMedia(context);
                      },
                    ),
                  ),

                  //submit button
                  new Container(
                      padding: const EdgeInsets.only(
                          left: 130, right: 130, top: 5.0),
                      child: new RaisedButton(
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _submitForm,
                      )),
                ],
              ),
            )));
  }

//recieve media attached array from Capture Media Screen
  void _awaitReturnValueFromMedia(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    if (inMediaAttached == null) {
      inMediaAttached = [];
    }

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CaptureMedia(mediaAttachments: inMediaAttached)));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      if (inMediaAttached != null) {
        inMediaAttached = result;
      } else {
        inMediaAttached = result;
      }
      _newForm.attachedMedia = inMediaAttached;
    });
  }

//show message at bottom of screen if try to submit in invalid form
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

//submit the form, for now just print the passed values
  void _submitForm() async {
    final FormState form = _formKey.currentState;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //Invoke each onSaved event
      _newForm.userNum = user.uid;
      print('Form is up to date...');
      print('User Id: ${_newForm.userNum}');
      print('Property Address: ${_newForm.paddress}');
      print('City: ${_newForm.city}');
      print('State: ${_newForm.state}');
      print('Zip Code: ${_newForm.zip}');
      print('Borrower: ${_newForm.borrower}');
      print('Owner of Public Record: ${_newForm.opubrec}');
      print('County: ${_newForm.county}');
      print('Legal Description: ${_newForm.legaldes}');
      print('Assessor Parcel Number: ${_newForm.apnum}');

      print('========================================');
      print('TODO: Send data to the back end...');
    }
    db
        .createNote(
      _newForm.userNum,
      _newForm.paddress,
      _newForm.city,
      _newForm.state,
      _newForm.zip,
      _newForm.borrower,
      _newForm.opubrec,
      _newForm.county,
      _newForm.legaldes,
      _newForm.apnum,
    )
        .then((_) {
      Navigator.pop(context);
    });
  }
}
