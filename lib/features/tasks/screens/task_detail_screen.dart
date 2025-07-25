import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_todo_app/core/models/task_model.dart';
import 'package:hackathon_todo_app/core/providers/task_provider.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final Task? task;
  const TaskDetailScreen({super.key, this.task});

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _timerController;
  DateTime? _dueDate;
  String _selectedCategory = 'Personal';
  String _selectedPriority = 'Medium';
  static const List<String> _categories = ['Personal', 'Work', 'Study', 'Shopping', 'Other'];
  static const List<String> _priorities = ['High', 'Medium', 'Low'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(text: widget.task?.description ?? '');
    _timerController = TextEditingController();
    _dueDate = widget.task?.dueDate;
    _selectedCategory = widget.task?.category ?? 'Personal';
    _selectedPriority = widget.task?.priority ?? 'Medium';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter a title' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                decoration: const InputDecoration(labelText: 'Priority'),
                items: _priorities.map((pri) => DropdownMenuItem(value: pri, child: Text(pri))).toList(),
                onChanged: (val) => setState(() => _selectedPriority = val!),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _timerController,
                decoration: const InputDecoration(labelText: 'Timer (minutes)'),
                keyboardType: TextInputType.number,
                validator: (value) => (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) <= 0)
                    ? 'Enter a valid timer in minutes'
                    : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Text(_dueDate == null ? 'No due date selected' : DateFormat.yMMMd().format(_dueDate!))),
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _dueDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) setState(() => _dueDate = pickedDate);
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _dueDate != null) {
                    final minutes = int.parse(_timerController.text);
                    final endTime = DateTime.now().add(Duration(minutes: minutes));
                    ref.read(taskListProvider.notifier).add(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dueDate: _dueDate!,
                          endTime: endTime,
                          category: _selectedCategory,
                          priority: _selectedPriority,
                        );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Task'),
              )
            ],
          ),
        ),
      ),
    );
  }
}