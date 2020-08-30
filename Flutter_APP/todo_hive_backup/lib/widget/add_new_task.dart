import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_hive/hivehelper/hivehelper.dart';
import 'package:todo_hive/model/task.dart';

class AddNewTask extends StatefulWidget {
  final Task task;
  final bool isEditMode;
  int taskKey;
  AddNewTask({this.task, this.isEditMode, this.taskKey});
  @override
  AddNewTaskState createState() => AddNewTaskState();
}

class AddNewTaskState extends State<AddNewTask> {
  Task task;
  Task task1;
  String _title;
  String _inputDescription;
  String _selectedTime = TimeOfDay.now().toString();
  String _selectedDate = DateFormat.yMMMd().format(DateTime.now()).toString();
  TimeOfDay _selectedTimes = TimeOfDay.now();
  DateTime _selectedDates = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  void _pickUserDueDate() {
    showDatePicker(
            context: context,
            initialDate: widget.isEditMode ? _selectedDates : DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((date) {
      if (date == null) {
        print('date is null ');
        return;
      }
      print('date is ggg: $_selectedDate ');
      date = date;
      setState(() {
        _selectedDates = date;
        _selectedDate = DateFormat.yMMMd().format(date).toString();
      });
    });
  }

  void _pickUserDueTime() {
    showTimePicker(
      context: context,
      initialTime: widget.isEditMode ? _selectedTimes : TimeOfDay.now(),
    ).then((time) {
      if (time == null) {
        return;
      }
      setState(() {
        _selectedTimes = time;
        _selectedTime = time.format(context);
      });
    });
  }

  void _validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_selectedDate == null && _selectedTime != null) {
        _selectedDate = DateFormat.yMMMd().format(DateTime.now()).toString();
      }
      if (!widget.isEditMode) {
        task1 = Task(
          title: _title,
          description: _inputDescription,
          dueDate: _selectedDate,
          dueTime: _selectedTime,
          isDone: false,
        );
        HiveHelper.helper.insertTask(task1);
      } else {
        HiveHelper.helper.updateTask(
            Task(
              title: _title,
              description: _inputDescription,
              dueDate: _selectedDate,
              dueTime: _selectedTime,
            ),
            widget.taskKey);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (widget.isEditMode) {
      task = HiveHelper.helper.getById(widget.taskKey);
      _title = task.title;
      _inputDescription = task.description;
      _selectedDate = task.dueDate;
      _selectedTime = task.dueTime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title', style: Theme.of(context).textTheme.subtitle),
            TextFormField(
              initialValue: _title == null ? null : _title,
              decoration: InputDecoration(
                hintText: 'Name your task',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                _title = value;
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Text('Decsribe the task',
                style: Theme.of(context).textTheme.subtitle),
            TextFormField(
              initialValue:
                  _inputDescription == null ? null : _inputDescription,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                hintText: 'Describe your task',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                _inputDescription = value;
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('Due Date',
                        style: Theme.of(context).textTheme.subtitle),
                    IconButton(
                        icon: Icon(Icons.date_range),
                        onPressed: () {
                          setState(() {
                            _pickUserDueDate();
                          });
                        }),
                    Text(_selectedDate == null
                        ? 'Provide your due date'
                        : _selectedDate),
                  ],
                ),
                SizedBox(
                  width: 50.h,
                ),
                Column(
                  children: <Widget>[
                    Text('Due Time',
                        style: Theme.of(context).textTheme.subtitle),
                    IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: () {
                          setState(() {
                            _pickUserDueTime();
                          });
                        }),
                    Text(_selectedDate == null
                        ? 'Provide your due time'
                        : _selectedTime)
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text(
                  !widget.isEditMode ? 'ADD TASK' : 'EDIT TASK',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Lato',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _validateForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
