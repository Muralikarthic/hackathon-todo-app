import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hackathon_todo_app/core/models/task_model.dart';
import 'package:hackathon_todo_app/core/providers/task_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';

class TaskListItem extends ConsumerStatefulWidget {
  final Task task;
  const TaskListItem({super.key, required this.task});

  @override
  ConsumerState<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends ConsumerState<TaskListItem> {
  late Duration _remaining;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _remaining = widget.task.endTime.difference(DateTime.now());
    _ticker = Ticker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final newRemaining = widget.task.endTime.difference(DateTime.now());
    if (mounted) {
      setState(() {
        _remaining = newRemaining;
      });
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = _remaining.isNegative;
    String timerText = isExpired
        ? 'Expired'
        : '${_remaining.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(_remaining.inSeconds.remainder(60)).toString().padLeft(2, '0')} left';
    return Slidable(
      key: ValueKey(widget.task.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => ref.read(taskListProvider.notifier).delete(widget.task.id),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: CheckboxListTile(
        title: Text(widget.task.title, style: TextStyle(decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Due: 	${DateFormat.yMMMd().format(widget.task.dueDate)}'),
            Text(timerText, style: TextStyle(color: isExpired ? Colors.red : Colors.green)),
          ],
        ),
        value: widget.task.isCompleted,
        onChanged: (bool? value) {
          widget.task.isCompleted = value ?? false;
          ref.read(taskListProvider.notifier).update(widget.task);
        },
      ),
    );
  }
}