import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hackathon_todo_app/core/models/task_model.dart';
import 'package:hackathon_todo_app/core/providers/task_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';
import 'package:confetti/confetti.dart';

class TaskListItem extends ConsumerStatefulWidget {
  final Task task;
  const TaskListItem({super.key, required this.task});

  @override
  ConsumerState<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends ConsumerState<TaskListItem> {
  late Duration _remaining;
  late final Ticker _ticker;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _remaining = widget.task.endTime.difference(DateTime.now());
    _ticker = Ticker(_onTick)..start();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  void _onTick(Duration elapsed) {
    if (mounted) {
      setState(() {
        _remaining = widget.task.endTime.difference(DateTime.now());
      });
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Work': return const Color(0xFF42A5F5);
      case 'Study': return const Color(0xFFAB47BC);
      case 'Shopping': return const Color(0xFFFF7043);
      case 'Other': return const Color(0xFF26A69A);
      default: return const Color(0xFF6C63FF);
    }
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'High': return const Color(0xFFE53935);
      case 'Low': return const Color(0xFF43A047);
      default: return const Color(0xFFFFB300);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = !_isCompleted() && DateTime.now().isAfter(widget.task.endTime);
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
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(widget.task.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, decoration: widget.task.isCompleted ? TextDecoration.lineThrough : null)),
                  ),
                  Chip(
                    label: Text(widget.task.category, style: const TextStyle(color: Colors.white)),
                    backgroundColor: _categoryColor(widget.task.category),
                  ),
                  const SizedBox(width: 6),
                  Chip(
                    label: Text(widget.task.priority, style: const TextStyle(color: Colors.white)),
                    backgroundColor: _priorityColor(widget.task.priority),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text('Due:  \t${DateFormat.yMMMd().format(widget.task.dueDate)}'),
              Row(
                children: [
                  if (widget.task.isCompleted)
                    const Text('Completed', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                  else if (isExpired)
                    const Text('Expired', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
                  else
                    Row(
                      children: [
                        const Icon(Icons.timer, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(_formatDuration(_remaining), style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  const Spacer(),
                  Checkbox(
                    value: widget.task.isCompleted,
                    onChanged: isExpired
                        ? null
                        : (bool? value) {
                            final wasCompleted = widget.task.isCompleted;
                            widget.task.isCompleted = value ?? false;
                            ref.read(taskListProvider.notifier).update(widget.task);
                            if (!wasCompleted && (value ?? false)) {
                              _confettiController.play();
                            }
                          },
                  ),
                  const SizedBox(width: 4),
                  const Text('Completed'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isCompleted() => widget.task.isCompleted;

  String _formatDuration(Duration duration) {
    if (duration.isNegative) return '00:00';
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }
}