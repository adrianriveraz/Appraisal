import 'package:appraisal_project/screens/form/datamodel/appraisal.dart';
import 'package:flutter/material.dart';
import 'package:appraisal_project/screens/home/widgets/goappform_button.dart';
import 'package:appraisal_project/screens/home/widgets/gosearchappform_button.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appraisal_project/screens/form/form.dart';
import 'package:appraisal_project/screens/form/datamodel/appraisal.dart';
import 'package:appraisal_project/service/firebase_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appraisal_project/screens/form/formdef.dart';
class DynamicListViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appraisal Forms')),
      body: BodyLayout(),
    );
  }
}

class BodyLayout extends StatefulWidget {
  @override
  BodyLayoutState createState() {
    return new BodyLayoutState();
  }
}

class BodyLayoutState extends State<BodyLayout> {
  // The GlobalKey keeps track of the visible state of the list items
  // while they are being animated.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<Appraisal> items;
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  StreamSubscription<QuerySnapshot> noteSub;

  @override
  void initState() {
    super.initState();

    items = new List();

    noteSub?.cancel();
    noteSub = db.getNoteList().listen((QuerySnapshot snapshot) {
      final List<Appraisal> notes = snapshot.documents
          .map((documentSnapshot) => Appraisal.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = notes;
      });
    });
  }

  @override
  void dispose() {
    noteSub?.cancel();
    super.dispose();
  }
  // backing data
  // List<String> _data = [
  //   '5900 Granite Pkwy',
  //   '1600 Pennslyvania Ave',
  //   '11 Wall Street'
  // ];
  @override
Widget build(BuildContext context) {
    return MaterialApp(
      title: 'grokonez Firestore Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('grokonez Firestore Demo'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].id}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].address}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10.0)),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 15.0,
                            child: Text(
                              '${position + 1}',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _deleteNote(context, items[position], position)),
                        ],
                      ),
                      // onTap: () => _navigateToNote(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () => _createNewNote(context),
        // ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: <Widget>[
  //       SizedBox(
  //         height: 600,
  //         child: AnimatedList(
  //           // Give the Animated list the global key
  //           key: _listKey,
  //           initialItemCount: _data.length,
  //           // Similar to ListView itemBuilder, but AnimatedList has
  //           // an additional animation parameter.
  //           itemBuilder: (context, index, animation) {
  //             // Breaking the row widget out as a method so that we can
  //             // share it with the _removeSingleItem() method.
  //             return _buildItem(_data[index], animation);
  //           },
  //         ),
  //       ),
  //       GoAppFormButton(),
  //       GoSearchAppFormButton(),
  //       // RaisedButton(
  //       //   child: Text('Insert Form', style: TextStyle(fontSize: 20)),
  //       //   onPressed: () {
  //       //     _insertSingleItem();
  //       //   },
  //       // ),
  //       // RaisedButton(
  //       //   child: Text('Remove Form', style: TextStyle(fontSize: 20)),
  //       //   onPressed: () {
  //       //     _removeSingleItem();
  //       //   },
  //       // )
  //     ],
  //   );
  // }

  // This is the animated row with the Card.
  Widget _buildItem(String item, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/appForm');
          },
          title: Text(
            item,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  // void _insertSingleItem() {
  //   String newItem = "Address";
  //   // Arbitrary location for demonstration purposes
  //   int insertIndex = 0;
  //   // Add the item to the data list.
  //   _data.insert(insertIndex, newItem);
  //   // Add the item visually to the AnimatedList.
  //   _listKey.currentState.insertItem(insertIndex);
  // }

  // void _removeSingleItem() {
  //   int removeIndex = 0;
  //   // Remove item from data list but keep copy to give to the animation.
  //   String removedItem = _data.removeAt(removeIndex);
  //   // This builder is just for showing the row while it is still
  //   // animating away. The item is already gone from the data list.
  //   AnimatedListRemovedItemBuilder builder = (context, animation) {
  //     return _buildItem(removedItem, animation);
  //   };
  //   // Remove the item visually from the AnimatedList.
  //   _listKey.currentState.removeItem(removeIndex, builder);
  // }

  void _deleteNote(BuildContext context, Appraisal note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  // void _navigateToNote(BuildContext context, Appraisal note) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AppForm(note)),
  //   );
  // }

  // void _createNewNote(BuildContext context) async {
  //   ApForm _newForm = new ApForm();
  //       FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //       _newForm.userNum = user.uid;
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) =>
  //             AppForm(Appraisal(_newForm.userNum,, '', '', '', '', '', '', '', '', ''))),
  //   );
  // }
}
