import 'package:check/adminFeild/AdminDashboard.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/constants.dart';
import '../provider/selected_task_provider.dart';

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
  void initState() {
    super.initState();
    _tickets.add(TicketEntry());
    final selectedTask = Provider.of<SelectedTaskProvider>(context, listen: false).selectedTask;
    print('Selected Task Data: $selectedTask');
  }

  void _addNewTicket() {
    setState(() {
      _tickets.add(TicketEntry());
      _showAddTicket = false; // Hide the add ticket option after adding
    });
  }

  void _removeTicket(int index) {
    setState(() {
      _tickets.removeAt(index);
      // Show add ticket option when a ticket is removed
      _showAddTicket = true;
    });
  }

  void _toggleAddTicket() {
    setState(() {
      _showAddTicket = !_showAddTicket;
    });
  }

  Future<void> _submitForm() async {
    final selectedTask = Provider.of<SelectedTaskProvider>(context).selectedTask;

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      _formKey.currentState!.save();

      try {
        var requestBody = {
          '_id':selectedTask?.taskId,
          "taskName": taskName,
          "userId": userId,
          "userName": userName,
          "tickets": _tickets.map((ticket) => {
            "ticketName": ticket.ticketName,
            "latitude": double.parse(ticket.latitude),
            "longitude": double.parse(ticket.longitude),
          }).toList(),
        };

        await AssignTask(json.encode(requestBody));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Task assigned successfully!'),
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

      //labelText: label,
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
    final selectedTask = Provider.of<SelectedTaskProvider>(context).selectedTask;
    print('Selected Task: $selectedTask');
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
                              initialValue: selectedTask?.taskName, // This value will be shown in the input field
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
                              initialValue: selectedTask?.userId, // This value will be shown in the input field
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
                              initialValue: selectedTask?.userName, // This value will be shown in the input field
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
                            backgroundColor:  Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            'Submit',
                            style: TextStyle(fontSize: 18,color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(int idx) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ticket ${idx + 1}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  if (_tickets.length > 1) // Only show delete if there's more than one ticket
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        _removeTicket(idx);
                        _toggleAddTicket(); // Show add ticket option when deleting
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _buildInputDecoration('Ticket Name', Icons.confirmation_number),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ticket name';
                  }
                  return null;
                },
                onSaved: (value) => _tickets[idx].ticketName = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _buildInputDecoration('Latitude', Icons.location_on),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter latitude';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _tickets[idx].latitude = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _buildInputDecoration('Longitude', Icons.explore),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter longitude';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _tickets[idx].longitude = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketEntry {
  String ticketName = '';
  String latitude = '';
  String longitude = '';
}

Future<void> AssignTask(String requestBody) async {
  const url = ApiConstants.assignTask;
  var headers = {
    'x-dhundhoo-session': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms',
    'Content-Type': 'application/json'
  };
  print('request body $requestBody');
  var request = http.Request('POST',Uri.parse('$url?x-dhundhoo-session=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJtYXJncmVnb3Jpb3NzY2hvb2xAZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwib3JnSGFuZGxlIjoiZDYwMGUzZmItMzE5Yy00MjRiLTlkZjYtZjVmNDk4ZDg1MGEyIiwiYWNjZXNzQ29kZSI6ImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUowYjJ0bGJpSTZJbUptWWpJMU9XTTBMVGM1T0dJdE5HVmpaQzA1TnpRM0xUVTFNemcxWXpRMllUUmlPQ0lzSW5ScGJXVnpkR0Z0Y0NJNk1UY3lPVFU0TURVME9UUXhNbjAuNENYYURoREJhVkFtSHM0NUtTb2l2UG0zRUJ6ejRWTVlnYVpxWGhlT1phRSIsInRpbWVab25lIjoiVVRDKzA1OjMwIiwidHlwZSI6Ik9SRyIsInZlcnNpb24iOiIwLjIuMCIsInBsYXRmb3JtIjoiV0VCIiwiZXhwaXJlc0F0IjoxNzI5NjY2OTQ5NTczfQ.MhorJ9_0uAkMNgzeUe-F_oO1eFU1YZhd_fBEltPWXBE'));
  request.body = requestBody;
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    print('sucess assign task');
  } else {
    throw Exception(response.reasonPhrase);
  }
}
