import 'package:check/provider/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeTaskProvider with ChangeNotifier {
  List<dynamic> tasks = [];
  bool isLoading = true;

  Future<void> fetchEmployeeTasks() async {
    const String url =EmployeeApiConstant.getAllEmployeeTasks;
    const Map<String, String> headers = {
      "x-dhundhoo-session": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbkBkaHVuZGhvby5jb20iLCJyb2xlIjoiQURNSU4iLCJvcmdIYW5kbGUiOiI0NTlmOTc3ZC05ZDU3LTQ3ZWMtOTllMy02YmRhNDQ2NGQzYmIiLCJhY2Nlc3NDb2RlIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjBiMnRsYmlJNklqbGpNalE1WXpJMUxUa3hObVl0TkRBME9DMWlOalZoTFRsaU9HWmlOemhsTXpsaE9DSXNJblJwYldWemRHRnRjQ0k2TVRjeU16QXlOalEwTmpJMk5IMC5qTVRVQTJkOTJZa1V4bEJ1bVFtb0hPQzdWY0dkallsV1o2bHVqak50bzdjIiwidGltZVpvbmUiOiJVVEMrMDU6MzAiLCJ0eXBlIjoiREhVTkRIT08iLCJ2ZXJzaW9uIjoiMC4yLjAiLCJwbGF0Zm9ybSI6IldFQiIsImV4cGlyZXNBdCI6MTcyMzExMjg1NjM2OH0.ico7pR8rISZcAZZWqfJ3gpGURL1Huiuj_WqLcGNubms"
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        tasks = json.decode(response.body);
      } else {
        print("Failed to load tasks: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching tasks: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
