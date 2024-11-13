import 'package:check/Home.dart';
import 'package:check/adminFeild/adminDrawerScreen.dart';
import 'package:check/adminFeild/adminProfile.dart';
import 'package:check/adminFeild/assignTask.dart';
import 'package:check/adminFeild/task_detail_screen.dart';
import 'package:check/adminFeild/updateTask.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/task_model.dart';
import '../provider/taskProvider.dart';

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
    // Fetch tasks on initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
  }

  final List<Widget> _pages = [
    // Display TaskCardsSection as the first item
    Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return taskProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: TaskCardsSection(tasks: taskProvider.tasks),
        );
      },
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation logic for bottom bar items
    switch (index) {
      case 0:
      // Tasks page logic is handled by the body with IndexedStack
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()),
        );
        break;
      case 2:
      // Add your Notifications screen navigation here
        break;
      case 3:
      // Navigate to AccountCreationScreen when the Profile icon is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountCreationScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade900,
        actions: [
      IconButton(
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MyLocation(),
        //   ),
        // );
      },
      ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (int result) {
              switch (result) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardSelectionScreen()),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TaskAssignmentForm()),
          );
        },
        backgroundColor: Colors.blueGrey[800],
        child: const Icon(Icons.add_box, color: Colors.white),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey.shade900,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.teal, // Set selected item color
        unselectedItemColor: Colors.white, // Set unselected item color
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
            icon: Icon(Icons.person_add_alt),
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

    // Sort tasks by createdAt date in descending order (latest first)
    List<Task> sortedTasks = List.from(tasks)
      ..sort((a, b) {
        DateTime dateA = a.createdAt != null ? DateTime.parse(a.createdAt!) : DateTime(1970);
        DateTime dateB = b.createdAt != null ? DateTime.parse(b.createdAt!) : DateTime(1970);
        return dateB.compareTo(dateA); // For descending order
      });


    return Column(
      children: sortedTasks.map((task) {
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
                        icon: const Icon(Icons.my_location, color: Colors.teal),
                        onPressed: () {
                          Provider.of<SelectedTaskProvider>(context,
                              listen: false)
                              .selectTask(task);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(),
                            ),
                          );
                        },
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
                    borderRadius: BorderRadius.circular(12),
                    value: (task.perStatus ?? 0) / 100,
                    backgroundColor: Colors.grey.shade300,
                    color: task.perStatus == 100
                        ? Colors.green
                        : Colors.orange,
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


