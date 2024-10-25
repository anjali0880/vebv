
import 'package:check/Home.dart';
import 'package:check/adminFeild/assignTask.dart';
import 'package:check/adminFeild/task_detail_screen.dart';
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

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()), // Your Map screen
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.notifications,color: Colors.white,), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountCreationScreen(),
              ),
            );
          }),
          IconButton(icon: const Icon(Icons.person,color: Colors.white), onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AccountCreationScreen(),
              ),
            );
          }),
        ],
      ),
      drawer: _buildDrawer(),

      body: taskProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskCardsSection(tasks: taskProvider.tasks),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TaskAssignmentForm(),
            ),
          );
          print("Floating action button pressed");
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white), // "+" symbol
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

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              color: Colors.blueGrey,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/avatar1.png"),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'I am Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Reports'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const DashboardSelectionScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}





// class TaskCardsSection extends StatelessWidget {
//   final List<Task> tasks;
//
//   const TaskCardsSection({required this.tasks});
//
//   Future<void> deleteTask(String taskId) async {
//     const String url = ApiConstants.deleteTask;
//     var headers = {
//       'x-dhundhoo-session':
//           'session'
//     };
//
//     var request = http.Request('DELETE', Uri.parse('$url?taskId=$taskId'));
//     request.body = '''''';
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 10,
//                 offset: Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(5.0),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade500,
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Task List',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...tasks.map((task) {
//                     return GestureDetector(
//                       onTap: () {
//                         Provider.of<SelectedTaskProvider>(context, listen: false)
//                             .selectTask(task);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => TaskDetailScreen()),
//                         );
//                       },
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: Card(
//                           margin: const EdgeInsets.symmetric(vertical: 8.0),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         task.taskName,
//                                         style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.blueGrey,
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.delete_outline, color: Colors.red),
//                                       onPressed: () {
//                                         deleteTask(task.taskId);  // Pass the taskId here
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(color: Colors.blueGrey[700]),
//                                 Text(
//                                   'Assigned To: ${task.userId ?? 'N/A'}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Assigned To: ${task.userName ?? 'N/A'}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   'taskId: ${task.taskId ?? 'N/A'}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Completion Status: ${task.perStatus != null ? '${task.perStatus}%' : ''}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//


class TaskCardsSection extends StatelessWidget {
  final List<Task> tasks;

  const TaskCardsSection({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Center(
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Task List',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...tasks.map((task) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<SelectedTaskProvider>(context, listen: false)
                            .selectTask(task);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskDetailScreen()),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
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
                                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                                      onPressed: () {
                                        // Call the deleteTask function from the provider
                                        taskProvider.deleteTask(task.taskId);
                                      },
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.blueGrey[700]),
                                Text(
                                  'Assigned To: ${task.userId ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Assigned To: ${task.userName ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Task ID: ${task.taskId ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Completion Status: ${task.perStatus != null ? '${task.perStatus}%' : 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: (task.perStatus ?? 0) / 100, // convert percentage to a value between 0 and 1
                                  backgroundColor: Colors.grey.shade300,
                                  color: Colors.red,
                                  minHeight: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

