//
// import 'package:check/Home.dart';
// import 'package:flutter/material.dart';
//
// class TaskHomePage extends StatefulWidget {
//   const TaskHomePage({super.key});
//
//   @override
//   _TaskHomePageState createState() => _TaskHomePageState();
// }
//
// class _TaskHomePageState extends State<TaskHomePage> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Employee Dashboard'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               child: Container(
//                 color: Colors.teal,
//                 child: const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: AssetImage("assets/avatar1.png"),
//                       backgroundColor: Colors.transparent,
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Employee Name',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.task),
//               title: const Text('My Tasks'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.map),
//               title: const Text('Map'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const DashboardSelectionScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: const Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   TasksOverviewCard(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
//           BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.teal,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
//
// class UserProfileCard extends StatelessWidget {
//   const UserProfileCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8),
//       child: ListTile(
//         leading: const CircleAvatar(
//           radius: 25,
//           backgroundImage: AssetImage("assets/avatar1.png"),
//           backgroundColor: Colors.transparent,
//         ),
//         title: const Text('Employee Name'),
//         subtitle: const Text('Tasks: 5'),
//         trailing: ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
//           child: const Text('Tasks'),
//         ),
//       ),
//     );
//   }
// }
//
// class TasksOverviewCard extends StatefulWidget {
//   const TasksOverviewCard({super.key});
//
//   @override
//   _TasksOverviewCardState createState() => _TasksOverviewCardState();
// }
//
// class _TasksOverviewCardState extends State<TasksOverviewCard> {
//   final List<Map<String, dynamic>> tasks = [
//     {
//       'title': 'Deliver Package A',
//       'description': 'Deliver package to location X',
//       'dueDate': 'Due: Oct 20, 2024',
//       'priority': 'High',
//       'completed': false,
//     },
//     {
//       'title': 'Collect Documents',
//       'description': 'Collect documents from client Y',
//       'dueDate': 'Due: Oct 21, 2024',
//       'priority': 'Medium',
//       'completed': false,
//     },
//     {
//       'title': 'Collect Parcels',
//       'description': 'Collect parcels from client Z',
//       'dueDate': 'Due: Oct 22, 2024',
//       'priority': 'Medium',
//       'completed': false,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final bottomSheetHeight = screenHeight * 0.9;
//
//     return Card(
//       margin: const EdgeInsets.all(8),
//       child: Column(
//         children: [
//           const ListTile(
//             title: Text(
//               'Tasks',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(
//             height: bottomSheetHeight,
//             child: ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                   child: Card(
//                     elevation: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   tasks[index]['title'],
//                                   style: const TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(tasks[index]['description']),
//                                 Text(tasks[index]['dueDate']),
//                                 Text('Priority: ${tasks[index]['priority']}'),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 5),
//                           Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Checkbox(
//                                 value: tasks[index]['completed'],
//                                 onChanged: (value) {
//                                   setState(() {
//                                     tasks[index]['completed'] = value;
//                                   });
//                                 },
//                               ),
//                               const Text('Mark Done', style: TextStyle(fontSize: 12)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  _TaskHomePageState createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  int _selectedIndex = 0;

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Container(
                color: Colors.teal,
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
                      'Employee Name',
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
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('My Tasks'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Map'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
  const TasksOverviewCard({super.key});

  @override
  _TasksOverviewCardState createState() => _TasksOverviewCardState();
}

class _TasksOverviewCardState extends State<TasksOverviewCard> {
  List<dynamic> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    const String url = "http://ec2-3-6-16-102.ap-south-1.compute.amazonaws.com:9003/field/gettask/8208452243";
    const Map<String, String> headers = {
      "x-dhundhoo-session": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms"
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          tasks = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Failed to load tasks: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          const ListTile(
            title: Text(
              'Tasks',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task['taskName'] ?? 'N/A',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text("Org ID: ${task['orgId'] ?? 'N/A'}"),
                              Text("User Name: ${task['userName'] ?? 'N/A'}"),
                              Text("Progress: ${task['perStatus']}%"),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: task['perStatus'] == 100,
                              onChanged: (value) {
                                setState(() {
                                  task['perStatus'] = value! ? 100 : task['perStatus'];
                                });
                              },
                            ),
                            const Text('Mark Done', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
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
