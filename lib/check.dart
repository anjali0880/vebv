// import 'package:check/Home.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart'; // Import for date formatting
//
// class MobileDashboardScreen extends StatefulWidget {
//   @override
//   _MobileDashboardScreenState createState() => _MobileDashboardScreenState();
// }
//
// class _MobileDashboardScreenState extends State<MobileDashboardScreen> {
//   List<Task> tasks = [
//     Task(id: 1, title: 'Develop UI', assignedTo: null),
//     Task(id: 2, title: 'Test API', assignedTo: null),
//     Task(id: 3, title: 'Write documentation', assignedTo: null),
//   ];
//
//   List<Employee> employees = [
//     Employee(id: 1, name: 'John Doe'),
//     Employee(id: 2, name: 'Jane Smith'),
//     Employee(id: 3, name: 'Mike Johnson'),
//   ];
//
//   String selectedEmployee = '';
//   final TextEditingController taskTitleController = TextEditingController();
//   final TextEditingController taskDescriptionController = TextEditingController();
//   DateTime? dueDate;
//   String priority = 'Low';
//
//   void _createTask() {
//     print('Task Assigned to: $selectedEmployee');
//     print('Task Title: ${taskTitleController.text}');
//     print('Description: ${taskDescriptionController.text}');
//     print('Due Date: ${dueDate.toString()}');
//     print('Priority: $priority');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         actions: [
//           IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.person), onPressed: () {}),
//         ],
//       ),
//       drawer: _buildDrawer(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildMapSection(),
//               const SizedBox(height: 16),
//               //_buildTaskOverview(),
//               const SizedBox(height: 16),
//               _buildTaskAssignmentSection(),
//               const SizedBox(height: 16),
//               // _buildEmployeeSection(),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawer() {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           // DrawerHeader(
//           //   decoration: BoxDecoration(color: Colors.blueGrey),
//           //   child: Text('Task Management', style: TextStyle(color: Colors.white, fontSize: 24)),
//           // ),
//           DrawerHeader(
//             child: Container(
//               color: Colors.blueGrey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 30, // Adjusted size for better visibility
//                     backgroundImage: AssetImage("assets/avatar1.png"),
//                     backgroundColor: Colors.transparent,
//                   ),
//                   SizedBox(height: 10), // Spacing between avatar and name
//                   Text(
//                     'I am Admin',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           _buildDrawerItem(Icons.dashboard, 'Dashboard'),
//           // _buildDrawerItem(Icons.assignment, 'Tasks'),
//           // _buildDrawerItem(Icons.person, 'Employees'),
//           // _buildDrawerItem(Icons.timer, 'Time Tracking'),
//           _buildDrawerItem(Icons.bar_chart, 'Reports'),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) =>DashboardSelectionScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _buildDrawerItem(IconData icon, String title) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       onTap: () {
//         // Handle navigation
//       },
//     );
//   }
//
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco coordinates
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   Widget _buildMapSection() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         color: Colors.green[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: _center,
//             zoom: 11.0,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTaskStat(String label, String value) {
//     return Column(
//       children: [
//         Text(label, style: const TextStyle(fontSize: 14)),
//         Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//       ],
//     );
//   }
//
//   Widget _buildEmployeeSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blueGrey[200],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Employee Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(child: _buildEmployeeStatus('Completed', Icons.check_circle, Colors.green)),
//               const SizedBox(width: 16),
//               Expanded(child: _buildEmployeeStatus('In Progress', Icons.access_time, Colors.orange)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmployeeStatus(String label, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 48),
//           const SizedBox(height: 8),
//           Text(label, style: const TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTaskOverview() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blueGrey[200],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Task Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//
//
//           // Circular PieChart
//           AspectRatio(
//             aspectRatio: 1, // Make it circular
//             child: PieChart(
//               PieChartData(
//                 sections: [
//                   PieChartSectionData(
//                     value: 15,
//                     title: 'Completed',
//                     color: Colors.blueGrey[400],
//                     radius: 60,
//                     titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                   PieChartSectionData(
//                     value: 10,
//                     title: 'Pending',
//                     color: Colors.blueGrey[300],
//                     radius: 60,
//                     titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                   PieChartSectionData(
//                     value: 5,
//                     title: 'Due',
//                     color: Colors.blueGrey[100],
//                     radius: 60,
//                     titleStyle: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
//                   ),
//                 ],
//                 sectionsSpace: 2, // Space between pie chart sections
//                 centerSpaceRadius: 40, // Empty space in the center
//               ),
//             ),
//           ),
//
//
//
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildTaskStat('Completed', '15'),
//               _buildTaskStat('Pending', '10'),
//               _buildTaskStat('Due', '5'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   // Widget _buildTaskOverview() {
//   //   return Container(
//   //     padding: const EdgeInsets.all(16),
//   //     decoration: BoxDecoration(
//   //       color: Colors.blueGrey[200],
//   //       borderRadius: BorderRadius.circular(12),
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         const Text('Task Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//   //         const SizedBox(height: 16),
//   //         AspectRatio(
//   //           aspectRatio: 16 / 9,
//   //           child: LineChart(
//   //             LineChartData(
//   //               gridData: const FlGridData(show: false),
//   //               titlesData: const FlTitlesData(show: false),
//   //               borderData: FlBorderData(show: true),
//   //               minX: 0,
//   //               maxX: 7,
//   //               minY: 0,
//   //               maxY: 6,
//   //               lineBarsData: [
//   //                 LineChartBarData(
//   //                   spots: [
//   //                     const FlSpot(0, 3),
//   //                     const FlSpot(1, 1),
//   //                     const FlSpot(2, 4),
//   //                     const FlSpot(3, 2),
//   //                     const FlSpot(4, 5),
//   //                     const FlSpot(5, 1),
//   //                     const FlSpot(6, 4),
//   //                   ],
//   //                   isCurved: true,
//   //                   color: Colors.blueGrey[100],
//   //                   barWidth: 4,
//   //                   isStrokeCapRound: true,
//   //                   dotData: const FlDotData(show: false),
//   //                   belowBarData: BarAreaData(show: false),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //         const SizedBox(height: 16),
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //           children: [
//   //             _buildTaskStat('Completed', '15'),
//   //             _buildTaskStat('Pending', '10'),
//   //             _buildTaskStat('Due', 'Pending'),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   // Widget _buildTaskAssignmentSection() {
//   //   return Container(
//   //     padding: const EdgeInsets.all(16),
//   //     decoration: BoxDecoration(
//   //       color: Colors.blueGrey[200],
//   //       borderRadius: BorderRadius.circular(16),
//   //       boxShadow: const [
//   //         BoxShadow(
//   //           color: Colors.black12,
//   //           blurRadius: 10,
//   //           offset: Offset(0, 4),
//   //         ),
//   //       ],
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         // Title section with darker background color
//   //         Container(
//   //           padding: const EdgeInsets.all(10),
//   //           decoration: BoxDecoration(
//   //             color: Colors.blueGrey[800],  // Darker background color for the title part
//   //             borderRadius: BorderRadius.circular(12),
//   //           ),
//   //           child: const Center(
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 Text(
//   //                   'Assign Task',
//   //                   style: TextStyle(
//   //                     fontSize: 25,
//   //                     fontWeight: FontWeight.bold,
//   //                     color: Colors.white,  // Text color changed to white for contrast
//   //                   ),
//   //                 ),
//   //                 SizedBox(width: 10),
//   //
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //         const SizedBox(height: 16),
//   //
//   //
//   //         Container(
//   //           decoration: BoxDecoration(
//   //             color: Colors.blueGrey[50],
//   //             borderRadius: BorderRadius.circular(10),
//   //             border: Border.all(color: Colors.blueGrey[300]!),
//   //           ),
//   //           padding: const EdgeInsets.symmetric(horizontal: 16),
//   //           child: DropdownButton<String>(
//   //             isExpanded: true,
//   //             underline: const SizedBox(),
//   //             hint: Text(
//   //               "Select Employee",
//   //               style: TextStyle(color: Colors.blueGrey[700]),
//   //             ),
//   //             value: selectedEmployee.isNotEmpty ? selectedEmployee : null,
//   //             items: employees.map((Employee employee) {
//   //               return DropdownMenuItem<String>(
//   //                 value: employee.name,
//   //                 child: Text(employee.name),
//   //               );
//   //             }).toList(),
//   //             onChanged: (value) {
//   //               setState(() {
//   //                 selectedEmployee = value ?? '';
//   //               });
//   //             },
//   //           ),
//   //         ),
//   //         const SizedBox(height: 20),
//   //
//   //         // Task Title Input
//   //         TextField(
//   //           controller: taskTitleController,
//   //           decoration: InputDecoration(
//   //             labelText: 'Task Title',
//   //             border: OutlineInputBorder(
//   //               borderRadius: BorderRadius.circular(10),
//   //             ),
//   //             filled: true,
//   //             fillColor: Colors.blueGrey[50],
//   //           ),
//   //         ),
//   //         const SizedBox(height: 20),
//   //
//   //         // Task Description Input
//   //         TextField(
//   //           controller: taskDescriptionController,
//   //           decoration: InputDecoration(
//   //             labelText: 'Task Description',
//   //             border: OutlineInputBorder(
//   //               borderRadius: BorderRadius.circular(10),
//   //             ),
//   //             filled: true,
//   //             fillColor: Colors.blueGrey[50],
//   //           ),
//   //           maxLines: 3,
//   //         ),
//   //         const SizedBox(height: 20),
//   //
//   //         // Due Date Picker
//   //         Row(
//   //           children: [
//   //             const SizedBox(width: 10),
//   //             Expanded(
//   //               child: GestureDetector(
//   //                 onTap: () async {
//   //                   final picked = await showDatePicker(
//   //                     context: context,
//   //                     initialDate: DateTime.now(),
//   //                     firstDate: DateTime(2000),
//   //                     lastDate: DateTime(2101),
//   //                   );
//   //                   if (picked != null && picked != dueDate) {
//   //                     setState(() {
//   //                       dueDate = picked;
//   //                     });
//   //                   }
//   //                 },
//   //                 child: Container(
//   //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.blueGrey[50],
//   //                     border: Border.all(color: Colors.blueGrey[300]!),
//   //                     borderRadius: BorderRadius.circular(10),
//   //                   ),
//   //                   child: Row(
//   //                     children: [
//   //                       Icon(Icons.calendar_today, color: Colors.blueGrey[600]),
//   //                       const SizedBox(width: 10),
//   //                       Text(
//   //                         dueDate == null ? 'Pick a due date' : DateFormat('yyyy-MM-dd').format(dueDate!),
//   //                         style: TextStyle(color: Colors.blueGrey[700]),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         const SizedBox(height: 20),
//   //
//   //         // Centered Assign Task Button
//   //         Center(
//   //           child: ElevatedButton.icon(
//   //             onPressed: _createTask,
//   //             style: ElevatedButton.styleFrom(
//   //               backgroundColor: Colors.blueGrey[800],
//   //               shape: RoundedRectangleBorder(
//   //                 borderRadius: BorderRadius.circular(12),
//   //               ),
//   //               padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//   //             ),
//   //
//   //             label: const Text(
//   //               'Assign Task',
//   //               style: TextStyle(color: Colors.white, fontSize: 16),
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildTaskAssignmentSection() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blueGrey[200],
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Centered Title
//           Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Assign Task',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueGrey[800],
//                   ),
//                 ),
//                 SizedBox(width: 10),
//
//               ],
//             ),
//           ),
//           SizedBox(height: 16),
//
//           // Employee Dropdown
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.blueGrey[50],
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.blueGrey[300]!),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: DropdownButton<String>(
//               isExpanded: true,
//               underline: SizedBox(),
//               hint: Text(
//                 "Select Employee",
//                 style: TextStyle(color: Colors.blueGrey[700]),
//               ),
//               value: selectedEmployee.isNotEmpty ? selectedEmployee : null,
//               items: employees.map((Employee employee) {
//                 return DropdownMenuItem<String>(
//                   value: employee.name,
//                   child: Text(employee.name),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedEmployee = value ?? '';
//                 });
//               },
//             ),
//           ),
//           SizedBox(height: 20),
//
//           // Task Title Input
//           TextField(
//             controller: taskTitleController,
//             decoration: InputDecoration(
//               labelText: 'Task Title',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               filled: true,
//               fillColor: Colors.blueGrey[50],
//             ),
//           ),
//           SizedBox(height: 20),
//
//           // Task Description Input
//           TextField(
//             controller: taskDescriptionController,
//             decoration: InputDecoration(
//               labelText: 'Task Description',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               filled: true,
//               fillColor: Colors.blueGrey[50],
//             ),
//             maxLines: 3,
//           ),
//           const SizedBox(height: 20),
//
//           // Due Date Picker
//           Row(
//             children: [
//               const SizedBox(width: 10),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () async {
//                     final picked = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (picked != null && picked != dueDate) {
//                       setState(() {
//                         dueDate = picked;
//                       });
//                     }
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.blueGrey[50],
//                       border: Border.all(color: Colors.blueGrey[300]!),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_today, color: Colors.blueGrey[600]),
//                         const SizedBox(width: 10),
//                         Text(
//                           dueDate == null ? 'Pick a due date' : DateFormat('yyyy-MM-dd').format(dueDate!),
//                           style: TextStyle(color: Colors.blueGrey[700]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//
//           // Centered Assign Task Button
//           Center(
//             child: ElevatedButton.icon(
//               onPressed: _createTask,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueGrey[800],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//               ),
//
//               label: Text(
//                 'Assign Task',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
// }
//
// class Task {
//   final int id;
//   final String title;
//   final String? assignedTo;
//
//   Task({required this.id, required this.title, this.assignedTo});
// }
//
// class Employee {
//   final int id;
//   final String name;
//
//   Employee({required this.id, required this.name});
// }
