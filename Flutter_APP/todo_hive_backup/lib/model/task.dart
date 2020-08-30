import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isDone;

  @HiveField(4)
  String dueDate;

  @HiveField(5)
  String dueTime;

  Task({
    @required this.title,
    @required this.description,
    this.isDone = false,
    this.dueDate,
    this.dueTime,
  });

  changeStatus() {
    isDone = !isDone;
  }
}
