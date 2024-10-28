//
// import 'package:check/Home.dart';
// import 'package:flutter/material.dart';
//
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
//
//               child: Container(
//                 color: Colors.teal,
//                 child: const Column(
//
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 30, // Adjusted size for better visibility
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
//                   MaterialPageRoute(builder: (context) =>const DashboardSelectionScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//
//       body: const Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   UserProfileCard(),
//                   TasksOverviewCard(),
//                 ],
//               ),
//             ),
//           ),
//           // TaskProgressBar(),
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
//   // Sample list of tasks
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
//       'title': 'collect Parcels',
//       'description': 'Collect documents from client Y',
//       'dueDate': 'Due: Oct 21, 2024',
//       'priority': 'Medium',
//       'completed': false,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
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
//             height: 300,
//             child: ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                   child: Card(
//                     elevation: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
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
//                           const SizedBox(width: 10),
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
//
// // class TaskProgressBar extends StatefulWidget {
// //   const TaskProgressBar({super.key});
// //
// //   @override
// //   _TaskProgressBarState createState() => _TaskProgressBarState();
// // }
// //
// // class _TaskProgressBarState extends State<TaskProgressBar> {
// //   final List<Map<String, dynamic>> tasks = [
// //     {
// //       'title': 'Deliver Package A',
// //       'completed': true,
// //     },
// //     {
// //       'title': 'Collect Documents',
// //       'completed': false,
// //     },
// //     {
// //       'title': 'Collect parcels',
// //       'completed': true,
// //     },
// //   ];
//
//   // double getCompletionPercentage() {
//   //   int completedCount = tasks.where((task) => task['completed']).length;
//   //   return (completedCount / tasks.length) * 100;
//   // }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     double completionPercentage = getCompletionPercentage();
// //     return Card(
// //       margin: const EdgeInsets.all(8), // Margin around the card
// //       elevation: 4, // Slight elevation for a shadow effect
// //       child: Container(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             const Text(
// //               'Task Completion Progress',
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 10),
// //             LinearProgressIndicator(
// //               value: completionPercentage / 100,
// //               minHeight: 10,
// //               backgroundColor: Colors.grey[300],
// //               color: Colors.teal,
// //             ),
// //             const SizedBox(height: 10),
// //             Text('${completionPercentage.toStringAsFixed(1)}% completed'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// //
// // class DueDatesCard extends StatelessWidget {
// //   const DueDatesCard({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Card(
// //       margin: EdgeInsets.all(8),
// //       child: Column(
// //         children: [
// //           ListTile(
// //               title: Text('Due Dates', style: TextStyle(fontWeight: FontWeight.bold))),
// //           Wrap(
// //             spacing: 8,
// //             children: [
// //               Chip(label: Text('Today')),
// //               Chip(label: Text('Tomorrow')),
// //               Chip(label: Text('Next Week')),
// //             ],
// //           ),
// //           SizedBox(height: 10,)
// //         ],
// //       ),
// //     );
// //   }
// // }




import 'package:check/Home.dart';
import 'package:flutter/material.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardSelectionScreen()),
                );
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

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/avatar1.png"),
          backgroundColor: Colors.transparent,
        ),
        title: const Text('Employee Name'),
        subtitle: const Text('Tasks: 5'),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          child: const Text('Tasks'),
        ),
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
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Deliver Package A',
      'description': 'Deliver package to location X',
      'dueDate': 'Due: Oct 20, 2024',
      'priority': 'High',
      'completed': false,
    },
    {
      'title': 'Collect Documents',
      'description': 'Collect documents from client Y',
      'dueDate': 'Due: Oct 21, 2024',
      'priority': 'Medium',
      'completed': false,
    },
    {
      'title': 'Collect Parcels',
      'description': 'Collect parcels from client Z',
      'dueDate': 'Due: Oct 22, 2024',
      'priority': 'Medium',
      'completed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.9;

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
          SizedBox(
            height: bottomSheetHeight,
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
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
                                  tasks[index]['title'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(tasks[index]['description']),
                                Text(tasks[index]['dueDate']),
                                Text('Priority: ${tasks[index]['priority']}'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: tasks[index]['completed'],
                                onChanged: (value) {
                                  setState(() {
                                    tasks[index]['completed'] = value;
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
          ),
        ],
      ),
    );
  }
}
