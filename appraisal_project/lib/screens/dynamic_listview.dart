import 'package:flutter/material.dart';
import 'package:appraisal_project/screens/home/widgets/goappform_button.dart';
import 'package:appraisal_project/screens/home/widgets/gosearchappform_button.dart';
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

  // backing data
  List<String> _data = [
    '5900 Granite Pkwy',
    '1600 Pennslyvania Ave',
    '11 Wall Street'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 600,
          child: AnimatedList(
            // Give the Animated list the global key
            key: _listKey,
            initialItemCount: _data.length,
            // Similar to ListView itemBuilder, but AnimatedList has
            // an additional animation parameter.
            itemBuilder: (context, index, animation) {
              // Breaking the row widget out as a method so that we can
              // share it with the _removeSingleItem() method.
              return _buildItem(_data[index], animation);
            },
          ),
        ),
        GoAppFormButton(),
        GoSearchAppFormButton(),
        // RaisedButton(
        //   child: Text('Insert Form', style: TextStyle(fontSize: 20)),
        //   onPressed: () {
        //     _insertSingleItem();
        //   },
        // ),
        // RaisedButton(
        //   child: Text('Remove Form', style: TextStyle(fontSize: 20)),
        //   onPressed: () {
        //     _removeSingleItem();
        //   },
        // )
      ],
    );
  }

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
}
