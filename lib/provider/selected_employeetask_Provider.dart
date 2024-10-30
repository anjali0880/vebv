// import 'package:flutter/material.dart';
//
// class SelectedEmployeeTaskProvider extends ChangeNotifier {
//   Map<String, dynamic>? _selectedEmployeeTask;
//
//   Map<String, dynamic>? get selectedEmployeeTask => _selectedEmployeeTask;
//
//   void setSelectedEmployeeTask(Map<String, dynamic> task) {
//     _selectedEmployeeTask = task;
//     notifyListeners();
//   }
//
//   void clearSelectedEmployeeTask() {
//     _selectedEmployeeTask = null;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';

class SelectedEmployeeTaskProvider extends ChangeNotifier {
  Map<String, dynamic>? _selectedEmployeeTask;

  Map<String, dynamic>? get selectedEmployeeTask => _selectedEmployeeTask;

  void setSelectedEmployeeTask(Map<String, dynamic> task) {
    _selectedEmployeeTask = task;
    notifyListeners();
  }

  void clearSelectedEmployeeTask() {
    _selectedEmployeeTask = null;
    notifyListeners();
  }

  void updateTicketStatus(String ticketName, String newStatus) {
    if (_selectedEmployeeTask != null) {
      final tickets = _selectedEmployeeTask!['tickets'] as List<dynamic>;
      for (var ticket in tickets) {
        if (ticket['ticketName'] == ticketName) {
          ticket['status'] = newStatus; // Update the ticket status
          break;
        }
      }
      notifyListeners(); // Notify listeners to update UI
    }
  }
}
