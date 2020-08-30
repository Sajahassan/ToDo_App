import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_hive/model/task.dart';

class HiveHelper {
  HiveHelper._();
  static HiveHelper helper = HiveHelper._();

  Box<Task> todoBox;
  // @override
  // void initState() {
  //    super.initState();
  //   todoBox = Hive.box<Task>('tasks');
  // }

  initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    Hive.registerAdapter(TaskAdapter());
    todoBox = await Hive.openBox('tasks');
  }

  List<Task> getAllTasks() {
    List<Task> tasksList = todoBox.values.toList();
    return tasksList != null ? tasksList : null;
  }

  List<Task> getCompleteTasks() {
    List<Task> tasksList =
        todoBox.values.where((element) => element.isDone == true).toList();
    return tasksList != null ? tasksList : null;
  }

  List<Task> getInCompleteTasks() {
    List<Task> tasksList =
        todoBox.values.where((element) => element.isDone == false).toList();
    return tasksList != null ? tasksList : null;
  }

  Task getById(int key) {
    return todoBox.get(key);
  }

  insertTask(Task task) {
    print('****///////hhhhhh ${task.title}');
    todoBox.add(task);
  }

  updateTask(Task task, int key) {
    //Task edittask = todoBox.get(key);
    todoBox.put(key, task);
  }

  changeTaskStatus(int key) {
    Task task = todoBox.get(key);
    task.changeStatus();
    todoBox.put(key, task);
  }

  deleteTask(int key) {
    todoBox.delete(key);
  }

  deleteAllTask() {
    List tasksKey = todoBox.keys.toList();
    todoBox.deleteAll(tasksKey);
  }

  deleteAllCompleteTask(List tasksKey) {
    todoBox.deleteAll(tasksKey);
  }

  deleteAllInCompleteTask(List tasksKey) {
    todoBox.deleteAll(tasksKey);
  }

  //  List<Task> sorAllTasks() {
  //   List<Task> tasksList = todoBox.values.toList().sort((a, b) => a.title.compareTo(b.title));
  //   return tasksList != null ? tasksList : null;
  // }
}
