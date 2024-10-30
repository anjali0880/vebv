// import 'package:check/provider/constants.dart';
// import 'package:check/provider/employee_task_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import '../provider/selected_employeetask_Provider.dart';
//
// class EmployeeTaskDetailScreen extends StatelessWidget {
//   const EmployeeTaskDetailScreen({Key? key}) : super(key: key);
//
//   Future<void> ticketCompletion(
//       BuildContext context, String taskName, String ticketName) async {
//     const String url = EmployeeApiConstant.taskCompletion;
//     var headers = {
//       'x-dhundhoo-session':
//           'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms' // Update with actual token or secure it properly
//     };
//
//     var request =
//         http.Request('POST', Uri.parse('$url/$taskName/$ticketName/completed'));
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       print('success');
//
//       // Update the status in the provider
//       Provider.of<SelectedEmployeeTaskProvider>(context, listen: false)
//           .updateTicketStatus(ticketName, 'COMPLETED');
//       Provider.of<EmployeeTaskProvider>(context, listen: false)
//           .fetchEmployeeTasks();
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final selectedEmployeeTask =
//         context.watch<SelectedEmployeeTaskProvider>().selectedEmployeeTask;
//
//     if (selectedEmployeeTask == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text('No employee task selected'),
//         ),
//       );
//     }
//
//     // Extract tickets from the selected task
//     final tickets = selectedEmployeeTask['tickets'] as List<dynamic>;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[800],
//         title: const Text('Employee Task Details'),
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               selectedEmployeeTask['taskName'] ?? 'N/A',
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text('Organization ID: ${selectedEmployeeTask['orgId'] ?? 'N/A'}'),
//             Text('User Name: ${selectedEmployeeTask['userName'] ?? 'N/A'}'),
//             Text(
//                 'Progress: ${selectedEmployeeTask['perStatus']?.toString() ?? 'N/A'}%'),
//             const SizedBox(height: 16),
//
//             // Displaying tickets with their location details
//             const Text(
//               'Tickets:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//
//             // ListView to display each ticket's details
//             Expanded(
//               child: ListView.builder(
//                 itemCount: tickets.length,
//                 itemBuilder: (context, index) {
//                   final ticket = tickets[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 5),
//                     child: ListTile(
//                       title:
//                           Text('Ticket Name: ${ticket['ticketName'] ?? 'N/A'}'),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Status: ${ticket['status'] ?? 'N/A'}'),
//                           Text(
//                               'Latitude: ${ticket['latitude']?.toString() ?? 'N/A'}'),
//                           Text(
//                               'Longitude: ${ticket['longitude']?.toString() ?? 'N/A'}'),
//                         ],
//                       ),
//                       trailing: Checkbox(
//                         value: ticket['status'] == 'COMPLETED',
//                         onChanged: (value) {
//                           if (value != null && value) {
//                             ticketCompletion(
//                               context,
//                               selectedEmployeeTask['taskName'] ?? 'N/A',
//                               ticket['ticketName'] ?? 'N/A',
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:check/provider/constants.dart';
// import 'package:check/provider/employee_task_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import '../provider/selected_employeetask_Provider.dart';
//
// class EmployeeTaskDetailScreen extends StatelessWidget {
//   const EmployeeTaskDetailScreen({Key? key}) : super(key: key);
//
//   Future<void> ticketStatusUpdate(
//       BuildContext context,
//       String taskName,
//       String ticketName,
//       String status,
//       ) async {
//     const String url = EmployeeApiConstant.taskCompletion;
//     var headers = {
//       'x-dhundhoo-session':
//          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms' // Update with actual token or secure it properly
//     };
//
//     var request = http.Request(
//       'POST',
//       Uri.parse('$url/$taskName/$ticketName/$status'),
//     );
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       print('Task update successful');
//
//       // Update the status in the provider
//       Provider.of<SelectedEmployeeTaskProvider>(context, listen: false)
//           .updateTicketStatus(ticketName, status);
//       Provider.of<EmployeeTaskProvider>(context, listen: false)
//           .fetchEmployeeTasks();
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final selectedEmployeeTask =
//         context.watch<SelectedEmployeeTaskProvider>().selectedEmployeeTask;
//
//     if (selectedEmployeeTask == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text('No employee task selected'),
//         ),
//       );
//     }
//
//     // Extract tickets from the selected task
//     final tickets = selectedEmployeeTask['tickets'] as List<dynamic>;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[800],
//         title: const Text('Employee Task Details'),
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               selectedEmployeeTask['taskName'] ?? 'N/A',
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text('Organization ID: ${selectedEmployeeTask['orgId'] ?? 'N/A'}'),
//             Text('User Name: ${selectedEmployeeTask['userName'] ?? 'N/A'}'),
//             Text(
//                 'Progress: ${selectedEmployeeTask['perStatus']?.toString() ?? 'N/A'}%'),
//             const SizedBox(height: 16),
//
//             // Displaying tickets with their location details
//             const Text(
//               'Tickets:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//
//             // ListView to display each ticket's details
//             Expanded(
//               child: ListView.builder(
//                 itemCount: tickets.length,
//                 itemBuilder: (context, index) {
//                   final ticket = tickets[index];
//                   return Card(
//                       elevation: 4,
//                       margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                   ),
//                     child: ListTile(
//                       title: Text('Ticket Name: ${ticket['ticketName'] ?? 'N/A'}'),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Status: ${ticket['status'] ?? 'N/A'}'),
//                           Text('Latitude: ${ticket['latitude']?.toString() ?? 'N/A'}'),
//                           Text('Longitude: ${ticket['longitude']?.toString() ?? 'N/A'}'),
//                         ],
//                       ),
//                       trailing: Checkbox(
//                         value: ticket['status'] == 'COMPLETED',
//                         onChanged: (value) {
//                           final newStatus = value! ? 'COMPLETED' : 'PENDING';
//                           ticketStatusUpdate(
//                             context,
//                             selectedEmployeeTask['taskName'] ?? 'N/A',
//                             ticket['ticketName'] ?? 'N/A',
//                             newStatus,
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:check/provider/constants.dart';
import 'package:check/provider/employee_task_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/selected_employeetask_Provider.dart';

class EmployeeTaskDetailScreen extends StatelessWidget {
  const EmployeeTaskDetailScreen({Key? key}) : super(key: key);

  Future<void> ticketStatusUpdate(
      BuildContext context,
      String taskName,
      String ticketName,
      String status,
      ) async {
    const String url = EmployeeApiConstant.taskCompletion;
    var headers = {
      'x-dhundhoo-session':
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms'
    };

    var request = http.Request(
      'POST',
      Uri.parse('$url/$taskName/$ticketName/$status'),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('Task update successful');

      Provider.of<SelectedEmployeeTaskProvider>(context, listen: false)
          .updateTicketStatus(ticketName, status);
      Provider.of<EmployeeTaskProvider>(context, listen: false)
          .fetchEmployeeTasks();
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedEmployeeTask =
        context.watch<SelectedEmployeeTaskProvider>().selectedEmployeeTask;

    if (selectedEmployeeTask == null) {
      return const Scaffold(
        body: Center(
          child: Text('No employee task selected'),
        ),
      );
    }

    final tickets = selectedEmployeeTask['tickets'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: const Text('Employee Task Details'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selectedEmployeeTask['taskName'] ?? 'N/A',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Organization ID: ${selectedEmployeeTask['orgId'] ?? 'N/A'}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(
              'User Name: ${selectedEmployeeTask['userName'] ?? 'N/A'}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(
              'Progress: ${selectedEmployeeTask['perStatus']?.toString() ?? 'N/A'}%',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tickets:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  final isCompleted = ticket['status'] == 'COMPLETED';

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.label_important,
                        color: isCompleted ? Colors.green : Colors.orange,
                        size: 30,
                      ),
                      title: Text(
                        'Ticket: ${ticket['ticketName'] ?? 'N/A'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[900],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status: ${ticket['status'] ?? 'N/A'}',
                            style: TextStyle(
                              color: isCompleted ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey[700],
                                size: 18,
                              ),
                              Text(
                                'Lat: ${ticket['latitude']?.toString() ?? 'N/A'}, Lon: ${ticket['longitude']?.toString() ?? 'N/A'}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          final newStatus = isCompleted ? 'PENDING' : 'COMPLETED';
                          ticketStatusUpdate(
                            context,
                            selectedEmployeeTask['taskName'] ?? 'N/A',
                            ticket['ticketName'] ?? 'N/A',
                            newStatus,
                          );
                        },
                        child: Icon(
                          isCompleted
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: isCompleted ? Colors.green : Colors.orange,
                          size: 30,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
