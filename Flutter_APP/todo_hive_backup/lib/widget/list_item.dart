import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_hive/model/task.dart';
import 'package:todo_hive/widget/add_new_task.dart';
import 'package:todo_hive/widget/item_text.dart';
import 'package:todo_hive/hivehelper/hivehelper.dart';

class ListItem extends StatefulWidget {
  final Task task;
  final int taskKey;

  ListItem({this.task, this.taskKey});

  @override
  ListItemState createState() => ListItemState();
}

class ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    void _checkItem() {
      setState(() {
        HiveHelper.helper.changeTaskStatus(widget.taskKey);
      });
    }

    return Dismissible(
      key: ValueKey(widget.taskKey),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        HiveHelper.helper.deleteTask(widget.taskKey);
      },
      background: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'DELETE',
              style: TextStyle(
                color: Theme.of(context).errorColor,
                fontFamily: 'Lato',
                fontSize: 16,
              ),
            ),
            SizedBox(width: 5.h),
            Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
              size: 28,
            ),
          ],
        ),
      ),
      child: GestureDetector(
          onTap: _checkItem,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                height: 85.h,
                child: Card(
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  elevation: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: widget.task.isDone,
                            onChanged: (_) => _checkItem(),
                          ),
                          ItemText(
                            widget.task.isDone,
                            widget.task.title,
                            widget.task.dueDate,
                            widget.task.dueTime,
                          ),
                        ],
                      ),
                      if (!widget.task.isDone)
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => AddNewTask(
                                task: widget.task,
                                isEditMode: true,
                                taskKey: widget.taskKey,
                              ),
                            );
                          },
                        )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
