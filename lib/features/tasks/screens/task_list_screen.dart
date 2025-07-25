import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_todo_app/core/providers/task_provider.dart';
import 'package:hackathon_todo_app/features/tasks/screens/task_detail_screen.dart';
import 'package:hackathon_todo_app/features/tasks/widgets/task_list_item.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';

class TaskListScreen extends ConsumerWidget {
  final VoidCallback? onLogout;
  const TaskListScreen({super.key, this.onLogout});

  static final List<String> _quotes = [
    "Success is the sum of small efforts, repeated day in and day out.",
    "The secret of getting ahead is getting started.",
    "Don’t watch the clock; do what it does. Keep going.",
    "It always seems impossible until it’s done.",
    "Great things are done by a series of small things brought together.",
    "You don’t have to be great to start, but you have to start to be great.",
    "Dream big. Start small. Act now.",
    "The best way to get something done is to begin.",
    "Every accomplishment starts with the decision to try.",
    "Stay positive, work hard, make it happen."
  ];

  String get randomQuote => _quotes[Random().nextInt(_quotes.length)];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the taskListProvider to get the list of tasks
    final tasks = ref.watch(taskListProvider);
    final quote = randomQuote;

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF48C6EF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.format_quote, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      quote,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(child: Lottie.asset('assets/no_tasks.json', width: 250))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return TaskListItem(task: tasks[index]);
                    },
                  ),
          ),
        ],
      ),
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