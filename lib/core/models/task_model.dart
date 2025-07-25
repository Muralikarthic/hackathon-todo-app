import 'package:hive/hive.dart';

part 'task_model.g.dart'; // This file will be generated next

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  DateTime endTime;

  @HiveField(6)
  String category;

  @HiveField(7)
  String priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    required this.endTime,
    this.category = 'Personal',
    this.priority = 'Medium',
  });
}