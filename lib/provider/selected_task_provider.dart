// import 'package:flutter/material.dart';
// import '../provider/task_model.dart';
//
// class SelectedTaskProvider with ChangeNotifier {
//   Task? _selectedTask;
//
//   Task? get selectedTask => _selectedTask;
//
//   void selectTask(Task task) {
//     _selectedTask = task;
//     notifyListeners(); // Notify listeners that the task has changed
//   }
//
//   void clearTask() {
//     _selectedTask = null;
//     notifyListeners(); // Notify listeners when the task is cleared
//   }
// }
import 'package:flutter/material.dart';
import '../provider/task_model.dart';

class SelectedTaskProvider with ChangeNotifier {
  Task? _selectedTask;

  Task? get selectedTask => _selectedTask;

  void selectTask(Task task) {
    _selectedTask = task;
    notifyListeners(); // Notify listeners that the task has changed
  }

  void clearTask() {
    _selectedTask = null;
    notifyListeners(); // Notify listeners when the task is cleared
  }

  // New method to remove a ticket from the selected task
  void removeTicket(String ticketName) {
    if (_selectedTask != null) {
      _selectedTask!.tickets.removeWhere((ticket) => ticket.ticketName == ticketName);
      notifyListeners(); // Notify listeners to update the UI
    }
  }
}
