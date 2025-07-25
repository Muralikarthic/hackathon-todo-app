import 'package:hackathon_todo_app/core/models/task_model.dart';
import 'package:hackathon_todo_app/core/repositories/task_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task_provider.g.dart'; // Will be generated

@riverpod
Uuid uuid(UuidRef ref) => const Uuid();

@riverpod
Future<Box<Task>> taskBox(TaskBoxRef ref) async => await Hive.openBox<Task>('tasks');

@riverpod
TaskRepository taskRepository(TaskRepositoryRef ref) {
  final box = ref.watch(taskBoxProvider).asData!.value;
  return TaskRepository(box, ref.read(uuidProvider));
}

@riverpod
class TaskList extends _$TaskList {
  @override
  List<Task> build() {
    ref.watch(taskBoxProvider); // Make sure we depend on the box being open
    return ref.watch(taskRepositoryProvider).getTasks();
  }

  Future<void> add({required String title, required String description, required DateTime dueDate, required DateTime endTime}) async {
    await ref.read(taskRepositoryProvider).addTask(title: title, description: description, dueDate: dueDate, endTime: endTime);
    ref.invalidateSelf();
  }

  Future<void> update(Task task) async {
    await ref.read(taskRepositoryProvider).updateTask(task);
    ref.invalidateSelf();
  }

  Future<void> delete(String id) async {
    await ref.read(taskRepositoryProvider).deleteTask(id);
    ref.invalidateSelf();
  }
}