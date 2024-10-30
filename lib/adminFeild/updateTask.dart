// import 'package:check/adminFeild/AdminDashboard.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// import '../provider/constants.dart';
// import '../provider/selected_task_provider.dart';
//
// class TaskUpdateForm extends StatefulWidget {
//   const TaskUpdateForm({Key? key}) : super(key: key);
//
//   @override
//   _TaskUpdateFormState createState() => _TaskUpdateFormState();
// }
//
// class _TaskUpdateFormState extends State<TaskUpdateForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<TicketEntry> _tickets = [];
//   bool _isLoading = false;
//   bool _showAddTicket = false;
//
//   String taskName = '';
//   String userId = '';
//   String userName = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _tickets.add(TicketEntry());
//
//   }
//
//   void _addNewTicket() {
//     setState(() {
//       _tickets.add(TicketEntry());
//       _showAddTicket = false; // Hide the add ticket option after adding
//     });
//   }
//
//   void _removeTicket(int index) {
//     setState(() {
//       _tickets.removeAt(index);
//       // Show add ticket option when a ticket is removed
//       _showAddTicket = true;
//     });
//   }
//
//   void _toggleAddTicket() {
//     setState(() {
//       _showAddTicket = !_showAddTicket;
//     });
//   }
//
//
//   Future<void> _submitForm() async {
//     final selectedTask = Provider.of<SelectedTaskProvider>(context, listen: false).selectedTask;
//
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//       _formKey.currentState!.save();
//
//       try {
//         var requestBody = jsonEncode({
//           '_id': selectedTask?.taskId,
//           "taskName": taskName,
//           "userId": userId,
//           "userName": userName,
//           "tickets": _tickets.map((ticket) => {
//             "ticketName": ticket.ticketName,
//             "latitude": double.parse(ticket.latitude),
//             "longitude": double.parse(ticket.longitude),
//           }).toList(),
//         });
//
//         if (selectedTask?.taskId != null) {
//           await UpdateTask(requestBody, selectedTask!.taskId);
//         }
//
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Row(
//                 children: const [
//                   Icon(Icons.check_circle, color: Colors.white),
//                   SizedBox(width: 8),
//                   Text('Task updated successfully!'),
//                 ],
//               ),
//               backgroundColor: Colors.green,
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         }
//       } catch (e) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Row(
//                 children: [
//                   const Icon(Icons.error, color: Colors.white),
//                   const SizedBox(width: 8),
//                   Text('Error: ${e.toString()}'),
//                 ],
//               ),
//               backgroundColor: Colors.red,
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         }
//       } finally {
//         if (mounted) {
//           setState(() => _isLoading = false);
//         }
//       }
//     }
//   }
//
//   InputDecoration _buildInputDecoration(String label, IconData icon) {
//     return InputDecoration(
//
//       //labelText: label,
//       prefixIcon: Icon(icon),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Colors.blue, width: 2),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.blue.shade200, width: 2),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Colors.blue, width: 2),
//       ),
//       filled: true,
//       fillColor: Colors.blue.shade50,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final selectedTask = Provider.of<SelectedTaskProvider>(context).selectedTask;
//     print('Selected Task: $selectedTask');
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey.shade800,
//         foregroundColor: Colors.white,
//         title: const Text('Update Task'),
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AdminDashboardScreen(),
//               ),
//             );
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.blue.shade100,
//                   Colors.white,
//                 ],
//               ),
//             ),
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Card(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               initialValue: selectedTask?.taskName, // This value will be shown in the input field
//                               decoration: _buildInputDecoration('Task Name', Icons.task),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter task name';
//                                 }
//                                 return null;
//                               },
//                               onSaved: (value) => taskName = value!,
//                             ),
//
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               initialValue: selectedTask?.userId, // This value will be shown in the input field
//                               decoration: _buildInputDecoration('User Id', Icons.person),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter user ID';
//                                 }
//                                 return null;
//                               },
//                               onSaved: (value) => userId = value!,
//                             ),
//
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               initialValue: selectedTask?.userName, // This value will be shown in the input field
//                               decoration: _buildInputDecoration('User Name', Icons.badge),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter user name';
//                                 }
//                                 return null;
//                               },
//                               onSaved: (value) => userName = value!,
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       'Ticket Details',
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue.shade800,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     ..._tickets.asMap().entries.map((entry) {
//                       return _buildTicketCard(entry.key);
//                     }).toList(),
//                     if (_showAddTicket)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Center(
//                           child: ElevatedButton.icon(
//                             onPressed: _addNewTicket,
//                             icon: const Icon(Icons.add),
//                             label: const Text('Add Ticket'),
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 24,
//                                 vertical: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     if (!_showAddTicket && _tickets.length < 5) // Limit to reasonable number
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Center(
//                           child: TextButton.icon(
//                             onPressed: _toggleAddTicket,
//                             icon: const Icon(Icons.add_circle_outline),
//                             label: const Text('Want to add another ticket?'),
//                           ),
//                         ),
//                       ),
//                     const SizedBox(height: 24),
//                     Center(
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _isLoading ? null : _submitForm,
//
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:  Colors.blue,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: _isLoading
//                               ? const CircularProgressIndicator(color: Colors.white)
//                               : const Text(
//                             'Submit',
//                             style: TextStyle(fontSize: 18,color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           if (_isLoading)
//             Container(
//               color: Colors.black26,
//               child: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTicketCard(int idx) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.white,
//               Colors.blue.shade50,
//             ],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Ticket ${idx + 1}',
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue.shade800,
//                     ),
//                   ),
//                   if (_tickets.length > 1) // Only show delete if there's more than one ticket
//                     IconButton(
//                       icon: const Icon(Icons.delete),
//                       color: Colors.red,
//                       onPressed: () {
//                         _removeTicket(idx);
//                         _toggleAddTicket(); // Show add ticket option when deleting
//                       },
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: _buildInputDecoration('Ticket Name', Icons.confirmation_number),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter ticket name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _tickets[idx].ticketName = value!,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: _buildInputDecoration('Latitude', Icons.location_on),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter latitude';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _tickets[idx].latitude = value!,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: _buildInputDecoration('Longitude', Icons.explore),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter longitude';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _tickets[idx].longitude = value!,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TicketEntry {
//   String ticketName = '';
//   String latitude = '';
//   String longitude = '';
// }
//
//
// Future<void> UpdateTask(String requestBody, String taskId) async {
//   const url = ApiConstants.updateTask;
//   var headers = {
//     'x-dhundhoo-session': '',
//     'Content-Type': 'application/json',
//   };
//
//   var request = http.Request('POST', Uri.parse('$url?taskId=$taskId'));
//   request.body = requestBody;
//   request.headers.addAll(headers);
//
//   print('Request body: $requestBody');
//
//   try {
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       print('Success: Task updated');
//     } else {
//       throw Exception(response.reasonPhrase);
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
//
import 'package:check/adminFeild/AdminDashboard.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/constants.dart';
import '../provider/selected_task_provider.dart';
import '../provider/taskProvider.dart';

class TaskUpdateForm extends StatefulWidget {
  const TaskUpdateForm({Key? key}) : super(key: key);

  @override
  _TaskUpdateFormState createState() => _TaskUpdateFormState();
}

class _TaskUpdateFormState extends State<TaskUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final List<TicketEntry> _tickets = [];
  bool _isLoading = false;
  bool _showAddTicket = false;

  String taskName = '';
  String userId = '';
  String userName = '';

  @override
  @override
  void initState() {
    super.initState();
    final selectedTask = Provider.of<SelectedTaskProvider>(context, listen: false).selectedTask;

    if (selectedTask != null) {
      taskName = selectedTask.taskName;
      userId = selectedTask.userId ?? ''; // Handle possible null with default empty string
      userName = selectedTask.userName ?? '';

      // Initialize _tickets based on selected task's tickets
      _tickets.addAll(selectedTask.tickets.map((ticket) => TicketEntry(
        ticketName: ticket.ticketName,
        latitude: ticket.latitude.toString(),
        longitude: ticket.longitude.toString(),
        status: ticket.status ?? '',
      )).toList());
    } else {
      // Handle case where selectedTask is null, possibly by showing a message or assigning defaults
      print('Selected task is null');
    }
  }


  void _addNewTicket() {
    setState(() {
      _tickets.add(TicketEntry());
      _showAddTicket = false;
    });
  }

  void _removeTicket(int index) {
    setState(() {
      _tickets.removeAt(index);

      _showAddTicket = true;
    });
  }

  void _toggleAddTicket() {
    setState(() {
      _showAddTicket = !_showAddTicket;
    });
  }

  Future<void> _submitForm() async {
    final selectedTask = Provider.of<SelectedTaskProvider>(context, listen: false).selectedTask;

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      _formKey.currentState!.save();

      try {
        var requestBody = jsonEncode({
          '_id': selectedTask?.taskId,
          "taskName": taskName,
          "userId": userId,
          "userName": userName,
          "tickets": _tickets.map((ticket) => {
            "ticketName": ticket.ticketName,
            "latitude": double.parse(ticket.latitude),
            "longitude": double.parse(ticket.longitude),
            // "status": ticket.status,
            "status": ticket.status == 'COMPLETED' ? 'COMPLETED' : null,
          }).toList(),
        });

        if (selectedTask?.taskId != null) {
          await UpdateTask(requestBody, selectedTask!.taskId);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Task updated successfully!'),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 8),
                  Text('Error: ${e.toString()}'),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue.shade200, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      filled: true,
      fillColor: Colors.blue.shade50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
        title: const Text('Update Task'),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDashboardScreen(),
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade100,
                  Colors.white,
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: taskName, // This value will be shown in the input field
                              decoration: _buildInputDecoration('Task Name', Icons.task),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter task name';
                                }
                                return null;
                              },
                              onSaved: (value) => taskName = value!,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: userId, // This value will be shown in the input field
                              decoration: _buildInputDecoration('User Id', Icons.person),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter user ID';
                                }
                                return null;
                              },
                              onSaved: (value) => userId = value!,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: userName, // This value will be shown in the input field
                              decoration: _buildInputDecoration('User Name', Icons.badge),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter user name';
                                }
                                return null;
                              },
                              onSaved: (value) => userName = value!,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Ticket Details',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._tickets.asMap().entries.map((entry) {
                      return _buildTicketCard(entry.key);
                    }).toList(),
                    if (_showAddTicket)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: _addNewTicket,
                            icon: const Icon(Icons.add),
                            label: const Text('Add Ticket'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!_showAddTicket && _tickets.length < 5) // Limit to reasonable number
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: TextButton.icon(
                            onPressed: _toggleAddTicket,
                            icon: const Icon(Icons.add_circle_outline),
                            label: const Text('Want to add another ticket?'),
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            'Submit',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_tickets[index].status == 'COMPLETED') ...[
              Text(
                'Ticket: ${_tickets[index].ticketName}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Status: ${_tickets[index].status}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Latitude: ${_tickets[index].latitude}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Longitude: ${_tickets[index].longitude}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ]

            else ...[
              TextFormField(
                initialValue: _tickets[index].ticketName,
                decoration: _buildInputDecoration('Ticket Name', Icons.assignment),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ticket name';
                  }
                  return null;
                },
                onSaved: (value) => _tickets[index].ticketName = value!,
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _tickets[index].latitude,
                decoration: _buildInputDecoration('Latitude', Icons.location_on),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter latitude';
                  }
                  return null;
                },
                onSaved: (value) => _tickets[index].latitude = value!,
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _tickets[index].longitude,
                decoration: _buildInputDecoration('Longitude', Icons.location_on),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter longitude';
                  }
                  return null;
                },
                onSaved: (value) => _tickets[index].longitude = value!,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status: ${_tickets[index].status}',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeTicket(index),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

Future<void> UpdateTask(String requestBody, String taskId) async {
  const url = AdminApiConstants.updateTask;
  var headers = {
    'x-dhundhoo-session': '',
    'Content-Type': 'application/json',
  };

  var request = http.Request('POST', Uri.parse('$url?taskId=$taskId'));
  request.body = requestBody;
  request.headers.addAll(headers);

  print('Request body: $requestBody');

  try {
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
      print('Success: Task updated');
    } else {
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    print('Error: $e');
  }
}

}

class TicketEntry {
  String ticketName;
  String latitude;
  String longitude;
  String status;

  TicketEntry({
    this.ticketName = '',
    this.latitude = '',
    this.longitude = '',
    this.status = '',
  });
}

