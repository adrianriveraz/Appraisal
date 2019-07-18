import 'package:flutter/material.dart';
import 'datamodel/appraisal.dart';
import 'package:appraisal_project/screens/form/formdef.dart';

// List for dropdown menu field states

String _ustate = null;

//Form Object defined
//ApForm _newForm = new ApForm();

//create form Widget
class DisplayForm extends StatefulWidget {
  @override
  _AppFormState createState() => new _AppFormState();
  DisplayForm({Key key, this.inForm}) : super(key: key);
  final Appraisal inForm;
}

//create State class to hold form data
class _AppFormState extends State<DisplayForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  // create form
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: Text('Appraisal Form'),
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
                  initialValue: widget.inForm.address,
                  //validator: (val) =>
                  //    val.isEmpty ? 'Property Address is required' : null,
                  //onSaved: (val) => _newForm.paddress = val,
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                  initialValue: widget.inForm.city,
                 // validator: (val) => val.isEmpty ? 'City is required' : null,
                 // onSaved: (val) => _newForm.city = val,
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'State',
                  ),
                  initialValue: widget.inForm.state,
                 // validator: (val) => val.isEmpty ? 'City is required' : null,
                 // onSaved: (val) => _newForm.city = val,
                ),

                
                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                  ),
                  initialValue: widget.inForm.zip,
                  //validator: (val) =>
                  //    val.isEmpty ? 'Zip Code is required' : null,
                  //onSaved: (val) => _newForm.zip = val,
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Borrower',
                  ),
                  initialValue: widget.inForm.borrower,
                  //validator: (val) =>
                  //    val.isEmpty ? 'Borrower is required' : null,
                  //onSaved: (val) => _newForm.borrower = val,
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Owner of Public Record',
                  ),
                  initialValue: widget.inForm.owner,
                  //validator: (val) =>
                  //    val.isEmpty ? 'Owner of Public Record is required' : null,
                  //onSaved: (val) => _newForm.opubrec = val,
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'County',
                  ),
                  initialValue: widget.inForm.county,
                  //validator: (val) => val.isEmpty ? 'County is required' : null,
                  //onSaved: (val) => _newForm.county = val,
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Legal Description',
                  ),
                  initialValue: widget.inForm.description,
                  //validator: (val) =>
                  //    val.isEmpty ? 'Legal Description is required' : null,
                  //onSaved: (val) => _newForm.legaldes = val,
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Assessor Parcel Number',
                  ),
                  initialValue: widget.inForm.parcel
                  //validator: (val) =>
                  //   val.isEmpty ? 'Assessor Parcel Number is required' : null,
                  //onSaved: (val) => _newForm.apnum = val,
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Number of Media Files Attached',
                  ),
                  initialValue: widget.inForm.mediaCaptured,
                 // validator: (val) => val.isEmpty ? 'City is required' : null,
                 // onSaved: (val) => _newForm.city = val,
                ),

                //submit button
               /*new Container(
                    padding:
                        const EdgeInsets.only(left: 105, right: 105, top: 20.0),
                    child: new RaisedButton(
                      child: const Text(
                        'Submit Search',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _submitForm,
                    )),*/
              ],
            ),
          ),
        ));
  }

//show message at bottom of screen if try to submit in invalid form
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

//submit the form, for now just print the passed values
  /*void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //Invoke each onSaved event

      print('Form is up to date...');
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
  }*/
}
