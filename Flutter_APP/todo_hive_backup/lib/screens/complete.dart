import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/hivehelper/hivehelper.dart';
import 'package:todo_hive/model/task.dart';
import 'package:todo_hive/widget/add_new_task.dart';
import 'package:todo_hive/widget/list_item.dart';

class Complete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    showDialogAlert(List keys) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Alert Dailog',
                style: TextStyle(fontSize: 20),
              ),
              content: Text('You Will Delete All Complete Tasks'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    print('delete ');
                    HiveHelper.helper.deleteAllCompleteTask(keys);
                    Navigator.pop(context);
                  },
                  child: Text('delete', style: TextStyle(color: Colors.cyan)),
                  splashColor: Colors.pink[100],
                ),
              ],
            );
          });
    }

    return Center(
      child: ValueListenableBuilder<Box<Task>>(
          valueListenable: HiveHelper.helper.todoBox.listenable(),
          builder: (context, value, child) {
            List<Task> tasks = value.values
                .where((element) => element.isDone == true)
                .toList();
            List<dynamic> keys = value.keys
                .where((element) => value.get(element).isDone == true)
                .toList();
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.grey[200],
                  leading: Icon(
                    Icons.home,
                    color: Colors.black45,
                  ),
                  title: Text('Complete Tasks ',
                      style: TextStyle(color: Colors.cyan)),
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
                        showDialogAlert(keys);
                      },
                      tooltip: 'Delete All Complete Task',
                    ),
                  ],
                ),
                body: tasks.length > 0
                    ? ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return ListItem(
                            task: tasks[index],
                            taskKey: keys[index],
                          );
                        },
                      )
                    : LayoutBuilder(
                        builder: (ctx, constraints) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: constraints.maxHeight * 0.5,
                                  child: Image.asset(
                                      'assets/images/waiting.png',
                                      fit: BoxFit.cover),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  'No tasks complete yet...',
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ],
                            ),
                          );
                        },
                      ));
          }),
    );
  }
}
