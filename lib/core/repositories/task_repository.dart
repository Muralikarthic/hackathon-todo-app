import 'package:hive_flutter/hive_flutter.dart';
import 'package:hackathon_todo_app/core/models/task_model.dart';
import 'package:uuid/uuid.dart';

// Handles all Task logic with the local Hive database
class TaskRepository {
  final Box<Task> _taskBox;
  final Uuid _uuid;

  TaskRepository(this._taskBox, this._uuid);

  List<Task> getTasks() {
    return _taskBox.values.toList();
  }

  Future<void> addTask({
    required String title,
    required String description,
    required DateTime dueDate,
    required DateTime endTime,
    required String category,
    required String priority,
  }) async {
    final task = Task(
      id: _uuid.v4(),
      title: title,
      description: description,
      dueDate: dueDate,
      endTime: endTime,
      category: category,
      priority: priority,
    );
    await _taskBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await task.save();
  }

  Future<void> deleteTask(String id) async {
    await _taskBox.delete(id);
  }
}