import 'package:check/Home.dart';
import 'package:check/adminFeild/adminDrawerScreen.dart';
import 'package:check/adminFeild/adminProfile.dart';
import 'package:check/adminFeild/assignTask.dart';
import 'package:check/adminFeild/task_detail_screen.dart';
import 'package:check/adminFeild/updateTask.dart';
import 'package:check/provider/adminInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/constants.dart';
import '../provider/task_model.dart';
import '../provider/taskProvider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:check/adminFeild/AdminMap.dart';
import 'package:check/adminFeild/CreateEmployeeForm.dart';
import '../provider/selected_task_provider.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation logic for bottom bar items
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notification action
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );

            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountCreationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: AdminDrawer(),
      body: taskProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: TaskCardsSection(tasks: taskProvider.tasks),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TaskAssignmentForm(),
            ),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey[400],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class TaskCardsSection extends StatelessWidget {
  final List<Task> tasks;

  const TaskCardsSection({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Column(
      children: tasks.map((task) {
        return GestureDetector(
          onTap: () {
            Provider.of<SelectedTaskProvider>(context, listen: false)
                .selectTask(task);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskDetailScreen()),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.assignment, color: Colors.teal),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          task.taskName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.teal),
                        onPressed: () {
                          Provider.of<SelectedTaskProvider>(context,
                              listen: false)
                              .selectTask(task);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskUpdateForm(),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          taskProvider.deleteTask(task.taskId);
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Assigned To: ${task.userName ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.numbers, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Task ID: ${task.taskId ?? 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      const Icon(Icons.bar_chart, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Completion Status: ${task.perStatus != null ? '${task.perStatus?.toStringAsFixed(2)}%' : 'N/A'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (task.perStatus ?? 0) / 100,
                    backgroundColor: Colors.grey.shade300,
                    color: task.perStatus == 100
                        ? Colors.green
                        : Colors.teal,
                    minHeight: 8,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
