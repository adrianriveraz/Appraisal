import 'package:flutter/material.dart';
import 'datamodel/appraisal.dart';

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
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                  initialValue: widget.inForm.city,
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'State',
                  ),
                  initialValue: widget.inForm.state,
                
                ),

                
                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                  ),
                  initialValue: widget.inForm.zip,
                 
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Borrower',
                  ),
                  initialValue: widget.inForm.borrower,
            
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Owner of Public Record',
                  ),
                  initialValue: widget.inForm.owner,
                  
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'County',
                  ),
                  initialValue: widget.inForm.county,
                
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Legal Description',
                  ),
                  initialValue: widget.inForm.description,
                
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Assessor Parcel Number',
                  ),
                  initialValue: widget.inForm.parcel
                  
                ),

                new TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Number of Media Files Attached',
                  ),
                  initialValue: widget.inForm.mediaCaptured,
                
                ),

               
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

}
