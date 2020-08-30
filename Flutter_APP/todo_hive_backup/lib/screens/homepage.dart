import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_hive/hivehelper/hivehelper.dart';
import 'package:todo_hive/widget/add_new_task.dart';
import 'package:todo_hive/widget/list.dart';

class Homepage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    showDialogAlert() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Alert Dailog',
                style: TextStyle(fontSize: 20),
              ),
              content: Text('You Will Delete All Tasks'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    print('delete ');
                    HiveHelper.helper.deleteAllTask();
                    Navigator.pop(context);
                  },
                  child: Text('delete', style: TextStyle(color: Colors.cyan)),
                  splashColor: Colors.pink[100],
                ),
              ],
            );
          });
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('user@domain.com'),
              accountName: Text('User Name'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Platform.isIOS ? Colors.blue : Colors.white,
                child: Text('S'),
              ),
            ),
            ListTile(
              title: Text('Sort'),
              leading: IconButton(
                icon: Icon(Icons.sort),
                onPressed: () {},
              ),
            ),
            ListTile(
              title: Text('Search'),
              leading: Icon(Icons.search),
            ),
            ListTile(
              title: Text('Reminder'),
              leading: Icon(Icons.alarm),
            ),
            ListTile(
              title: Text('About US'),
              leading: Icon(Icons.info),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: IconButton(
            icon: Icon(Icons.more_vert),
            color: Colors.black45,
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
        title: Text('Tasks ', style: TextStyle(color: Colors.cyan)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => AddNewTask(isEditMode: false),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialogAlert();
              // HiveHelper.helper.deleteAllTask();
            },
          ),
        ],
      ),
      body: ListClass(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => AddNewTask(isEditMode: false),
          );
        },
        tooltip: 'Add a new item!',
      ),
    );
  }
}

// class ShowDialog extends StatelessWidget {
//   @override
// Widget build(BuildContext context) {
// showDialogAlert() {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('alert Dailog'),
//           content: Text('You Wil Delete All Tasks'),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50)),
//           actions: <Widget>[
//             RaisedButton(
//               onPressed: () {
//                 print('delete ');
//                 HiveHelper.helper.deleteAllTask();
//                 Navigator.pop(context);
//               },
//               child: Text('delete'),
//             ),
//           ],
//         );
//       });
// }

//     return showDialogAlert();
//   }
// }
