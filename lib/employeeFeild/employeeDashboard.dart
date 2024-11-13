import 'package:check/employeeFeild/employeeDrawerScreen.dart';
import 'package:check/employeeFeild/employeemap.dart';
import 'package:check/employeeFeild/selectedTaskDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/employee_task_provider.dart';
import '../provider/selected_employeetask_Provider.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeTaskProvider>(context, listen: false).fetchEmployeeTasks();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
      ),
      drawer: const CustomDrawer(),
      body: const Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TasksOverviewCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}

class TasksOverviewCard extends StatefulWidget {
  const TasksOverviewCard({Key? key}) : super(key: key);

  @override
  _TasksOverviewCardState createState() => _TasksOverviewCardState();
}

class _TasksOverviewCardState extends State<TasksOverviewCard> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<EmployeeTaskProvider>(context);

    if (taskProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.task_alt, color: Colors.teal),
            title: Text(
              'Tasks Overview',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              final completion = (task['perStatus'] ?? 0) / 100.0;

              return GestureDetector(
                onTap: () {
                  // Store selected task data in SelectedTaskProvider
                  Provider.of<SelectedEmployeeTaskProvider>(context, listen: false)
                      .setSelectedEmployeeTask(task);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmployeeTaskDetailScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Card(
                    color: Colors.grey[100],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.assignment, color: Colors.teal),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  task['taskName'] ?? 'N/A',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.info_outline,
                                  color: Colors.grey[700],
                                ),
                                onPressed: () {
                                  // Optional: Provide additional task details on tap
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.share_location,
                                  color: Colors.grey[700],
                                ),
                                onPressed: () {
                                  Provider.of<SelectedEmployeeTaskProvider>(context, listen: false)
                                      .setSelectedEmployeeTask(task);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  EmployeeMapComponent(),
                                    ),
                                  );

                                  // Optional: Provide additional task details on tap
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: completion,
                            color: Colors.teal,
                            backgroundColor: Colors.teal[100],
                            minHeight: 6,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Completion: ${task['perStatus']}%",
                                style: const TextStyle(fontSize: 14),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: task['perStatus'] == 100,
                                    fillColor: WidgetStateProperty.resolveWith((states) {
                                      if (states.contains(WidgetState.selected)) {
                                        return Colors.teal; // Color when checkbox is checked
                                      }
                                      return Colors.white; // Color when checkbox is unchecked
                                    }),
                                    onChanged: (value) {
                                      // Implement completion logic if needed
                                    },
                                  ),
                                  const Text(
                                    'Mark Done',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
