import 'package:flutter/material.dart';
import 'package:appraisal_project/screens/form/formdef.dart';
// List for dropdown menu field states
List<String> _ustates = <String>['AL','AK','AZ','AR','CA','CO','CT'
,'DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA'
,'MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH'
,'OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI'
,'WY'];
  String _ustate = null;

//Form Object defined
ApForm newForm = new ApForm();

//create form Widget
class AppForm extends StatefulWidget{
  @override 
  AppFormState createState() => new AppFormState();
}

//create State class to hold form data
class AppFormState extends State<AppForm>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override 
  // create form
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text('Uniform Residential Appraisal Report'),
      ),
      body: new SafeArea(
        top:false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: true, //validate form as data is entered
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.home),
                  labelText: 'Property Address',
                ),
                validator: (val) => val.isEmpty ? 'Property Address is required' : null,
                onSaved: (val) => newForm.paddress = val,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.chevron_right),
                  labelText: 'City',
                ),
                validator: (val) => val.isEmpty ? 'City is required' : null,
                onSaved: (val) => newForm.city = val,
              ),

              new FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.chevron_right),
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
                            newForm.state = newValue;
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
                onSaved: (val) => newForm.state = val,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.chevron_right),
                  labelText: 'Zip Code',
                ),
                validator: (val) => val.isEmpty ? 'Zip Code is required' : null,
                onSaved: (val) => newForm.zip = val,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.chevron_right),
                  labelText: 'Borrower',
                ),
                validator: (val) => val.isEmpty ? 'Borrower is required' : null,
                onSaved: (val) => newForm.borrower = val,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.chevron_right),
                  labelText: 'Owner of Public Record',
                ),
                validator: (val) => val.isEmpty ? 'Owner of Public Record is required' : null,
                onSaved: (val) => newForm.opubrec = val,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.chevron_right),
                  labelText: 'County',
                ),
                validator: (val) => val.isEmpty ? 'County is required' : null,
                onSaved: (val) => newForm.county = val,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.chevron_right),
                  labelText: 'Legal Description',
                ),
                validator: (val) => val.isEmpty ? 'Legal Description is required' : null,
                onSaved: (val) => newForm.legaldes = val,
              ),

              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.chevron_right),
                  labelText: 'Assessor Parcel Number',
                ),
                validator: (val) => val.isEmpty ? 'Assessor Parcel Number is required' : null,
                onSaved: (val) => newForm.apnum = val,
              ),

              //submit button
              new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: _submitForm,
            )),
            ], 
          ),
        ),
      )
      );
  }

//show message at bottom of screen if try to submit in invalid form
   void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }

//submit the form, for now just print the passed values
  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //Invoke each onSaved event

      print('Form is up to date...');
      print('Property Address: ${newForm.paddress}');
      print('City: ${newForm.city}');
      print('State: ${newForm.state}');
      print('Zip Code: ${newForm.zip}');
      print('Borrower: ${newForm.borrower}');
      print('Owner of Public Record: ${newForm.opubrec}');
      print('County: ${newForm.county}');
      print('Legal Description: ${newForm.legaldes}');
      print('Assessor Parcel Number: ${newForm.apnum}');
      print('========================================');
      print('TODO: Send data to the back end...');
    }
  }
}

