import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'task_model.dart';
import 'task_provider.dart';

class AllTaskPage extends StatelessWidget {
  const AllTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: true);

    void showTaskDialog({Task? task, int? index}) {
      final isEditing = task != null;
      String? selectedCategory = isEditing ? task.category : null;
      DateTime? selectedDate = isEditing ? task.date : null;
      TimeOfDay? selectedTime = isEditing ? task.time : null;
      String? taskTitle = isEditing ? task.title : null;
      String? taskDetails = isEditing ? task.details : null;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(isEditing ? 'Edit Task' : 'Add Task'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    hint: const Text('Select Category'),
                    items: [
                      'All Task',
                      'Personal',
                      'Work',
                      'Ideas',
                      'At Work',
                      'Urgent',
                    ]
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (value) {
                      selectedCategory = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Select Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) selectedDate = pickedDate;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Select Time',
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                      );
                      if (pickedTime != null) selectedTime = pickedTime;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: taskTitle,
                    decoration: const InputDecoration(hintText: 'Task Title'),
                    onChanged: (value) {
                      taskTitle = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: taskDetails,
                    maxLines: 3,
                    decoration: const InputDecoration(hintText: 'Task Details'),
                    onChanged: (value) {
                      taskDetails = value;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedCategory != null &&
                      selectedDate != null &&
                      selectedTime != null &&
                      taskTitle != null &&
                      taskDetails != null) {
                    final newTask = Task(
                      category: selectedCategory!,
                      date: selectedDate!,
                      time: selectedTime!,
                      title: taskTitle!,
                      details: taskDetails!,
                    );
                    if (isEditing) {
                      taskProvider.updateTask(index!, newTask);
                    } else {
                      taskProvider.addTask(newTask);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(isEditing ? 'Save Changes' : 'Add Task'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MY LIST'),
        backgroundColor: Colors.blue,
      ),
      body: taskProvider.tasks.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Category: ${task.category}'),
                        Text(
                            'Date: ${task.date.day}/${task.date.month}/${task.date.year}'),
                        Text('Time: ${task.time.format(context)}'),
                        Text('Details: ${task.details}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showTaskDialog(task: task, index: index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            taskProvider.deleteTask(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTaskDialog(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
