import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/hivehelper/hivehelper.dart';
import 'package:todo_hive/model/task.dart';
import 'package:todo_hive/widget/list_item.dart';

class ListClass extends StatelessWidget {
  List<Task> taskList;

  @override
  void initState() {
    // super.initState();
    HiveHelper.helper.todoBox = Hive.box<Task>('tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<Box<Task>>(
          valueListenable: HiveHelper.helper.todoBox.listenable(),
          builder: (context, value, child) {
            List<Task> tasks = value.values.toList();
            List<dynamic> keys = value.keys.toList();
            taskList = tasks;
            return taskList.length > 0
                ? ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      return ListItem(
                        task: taskList[index],
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
                              child: Image.asset('assets/images/waiting.png',
                                  fit: BoxFit.cover),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              'No tasks added yet...',
                              style: Theme.of(context).textTheme.title,
                            ),
                          ],
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
