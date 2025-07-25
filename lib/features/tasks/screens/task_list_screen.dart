import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_todo_app/core/providers/task_provider.dart';
import 'package:hackathon_todo_app/features/tasks/screens/task_detail_screen.dart';
import 'package:hackathon_todo_app/features/tasks/widgets/task_list_item.dart';
import 'package:lottie/lottie.dart';

class TaskListScreen extends ConsumerWidget {
  final VoidCallback? onLogout;
  const TaskListScreen({super.key, this.onLogout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the taskListProvider to get the list of tasks
    // The UI will automatically rebuild when this list changes
    final tasks = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        automaticallyImplyLeading: false, // Prevents a back button from showing
        actions: [
          if (onLogout != null)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: onLogout,
              tooltip: 'Logout',
            ),
        ],
      ),
      body: tasks.isEmpty
          // If there are no tasks, show the Lottie animation
          ? Center(child: Lottie.asset('assets/no_tasks.json', width: 250))
          // Otherwise, display the tasks in a list
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskListItem(task: tasks[index]);
              },
            ),
      // The floating action button to add new tasks
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}