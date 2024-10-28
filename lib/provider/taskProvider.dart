import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../provider/task_model.dart';
import '../provider/constants.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = true;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  Future<void> fetchTasks() async {
    const fetchTaskUrl = ApiConstants.getAllTasksEndpoint;
    var headers = {
      'x-dhundhoo-session': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms',
    };

    try {
      var response = await http.get(Uri.parse(fetchTaskUrl), headers: headers);

      if (response.statusCode == 200) {

        var data = jsonDecode(response.body) as List;

        _tasks = data.map((taskJson) => Task.fromJson(taskJson)).toList();
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    const String url = ApiConstants.deleteTask;
    var headers = {
      'x-dhundhoo-session': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms',
    };

    var request = http.Request('DELETE', Uri.parse('$url?taskId=$taskId'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      _tasks.removeWhere((task) => task.taskId == taskId);
      notifyListeners();
    } else {
      print('Failed to delete task: ${response.reasonPhrase}');
    }
  }
}

