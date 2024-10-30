
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/constants.dart';
import '../provider/selected_task_provider.dart';
import 'package:http/http.dart' as http;

class TaskDetailScreen extends StatelessWidget {


  Future<void> deleteTicket(String ticketName, String taskName, BuildContext context) async {
    var headers = {
      'x-dhundhoo-session':
       'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms',
     // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms'
    };

    const String url = AdminApiConstants.deleteTicket;
    var request = http.Request('DELETE', Uri.parse('$url?ticketName=$ticketName&taskName=$taskName'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('Success'); // Successful response

      // Remove the ticket from the provider after successful deletion
      Provider.of<SelectedTaskProvider>(context, listen: false).removeTicket(ticketName);
    } else {
      print(response.reasonPhrase); // Error response
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTask = Provider.of<SelectedTaskProvider>(context).selectedTask;

    if (selectedTask == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Task Selected'),
        ),
        body: const Center(
          child: Text('Please select a task from the task list.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Heading Section
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        selectedTask.taskName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Assigned To Section
                  Text(
                    'Assigned To: ${selectedTask.userId ?? 'N/A'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Assigned User: ${selectedTask.userName ?? 'N/A'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),

                  // Completion Status Section
                  Text(
                    'Completion Status: ${selectedTask.perStatus != null ? '${selectedTask.perStatus}%' : 'N/A'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),

                  // Tickets Heading
                  const Text(
                    'Tickets:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  ...selectedTask.tickets.map((ticket) {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
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
                                    ticket.ticketName,
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
                                    deleteTicket(ticket.ticketName, selectedTask.taskName, context); // Pass the context
                                  },
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 8),

                            // Ticket Coordinates
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.red),
                                const SizedBox(width: 8),
                                Text(
                                  'Lat: ${ticket.latitude}, Lng: ${ticket.longitude}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Ticket Status
                            Row(
                              children: [
                                const Icon(Icons.info, color: Colors.blue),
                                const SizedBox(width: 8),
                                Text(
                                  'Status: ${ticket.status ?? 'N/A'}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
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
