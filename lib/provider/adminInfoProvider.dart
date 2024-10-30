// import 'dart:convert';
// import 'package:check/provider/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// Future<void> adminInfo(String taskId) async {
//   const String url = AuthApiConstants.adminInfo;
//   var headers = {
//     'x-dhundhoo-session': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJtYXJncmVnb3Jpb3NzY2hvb2xAZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwib3JnSGFuZGxlIjoiZDYwMGUzZmItMzE5Yy00MjRiLTlkZjYtZjVmNDk4ZDg1MGEyIiwiYWNjZXNzQ29kZSI6ImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUowYjJ0bGJpSTZJakkxWW1WbFpESmpMVGc0Wm1NdE5EaGtNaTA0TkdFNExUSm1Zak5sWkRRM1l6RmpOeUlzSW5ScGJXVnpkR0Z0Y0NJNk1UY3lPVFU0TVRZME1Ea3lOMzAuNnc0OUhzWERRQ0ZfSDMzdkdJN1M3Unl5dUxmaFFvNndPdDhvcWtSY1p2dyIsInRpbWVab25lIjoiVVRDKzA1OjMwIiwidHlwZSI6Ik9SRyIsInZlcnNpb24iOiIwLjIuMCIsInBsYXRmb3JtIjoiV0VCIiwiZXhwaXJlc0F0IjoxNzI5Njc3MDU5NTc0fQ.jYo3UoskR9D8iwn3aMuH1Z1OzoIUAq9x8nq3I7AOPFk'
//   };
//   var request = http.Request('GET', Uri.parse(
//       'url'));
//   request.body = '''''';
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   }
//   else {
//     print(response.reasonPhrase);
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class AdminProvider with ChangeNotifier {
  String _avatarUrl = "assets/avatar1.png";
  String _email = "I am Admin";
  String _phoneNumber = "Not Available";

  String get avatarUrl => _avatarUrl;
  String get email => _email;
  String get phoneNumber => _phoneNumber;

  Future<void> fetchAdminInfo() async {
    const String url = AuthApiConstants.adminInfo;
    var headers = {
      'x-dhundhoo-session':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbi50bWtAcGViYmxlY3JlZWtsaWZlc2Nob29sLmluIiwicm9sZSI6IkFETUlOIiwib3JnSGFuZGxlIjoiZGRiZGFhMmUtZmJiYi00ZjNjLWEyODAtZmNmYmJhY2QzZTM1IiwiYWNjZXNzQ29kZSI6ImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUowYjJ0bGJpSTZJbUptWWpJMU9XTTBMVGM1T0dJdE5HVmpaQzA1TnpRM0xUVTFNemcxWXpRMllUUmlPQ0lzSW5ScGJXVnpkR0Z0Y0NJNk1UY3lPVGswTnpVNE5ESXpOSDAuLXBmRTJWNGhtYlgwRFBoa3o1N2NIZHpPZ211TzFZUzBDVkUwdU8wcEhLSSIsInRpbWVab25lIjoiVVRDKzA1OjMwIiwidHlwZSI6Ik9SRyIsInZlcnNpb24iOiIwLjIuMCIsInBsYXRmb3JtIjoiV0VCIiwiZXhwaXJlc0F0IjoxNzMwMDMzOTk4ODk3fQ.XEuIY-lqpWp52pIFqnT2ZD6y5d1siGqZB5K_XCUGT-0'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _avatarUrl = data['accountModel']['account']['avatar'] ??
            "assets/avatar1.png";
        _email = data['accountModel']['account']['emailId'] ?? "I am Admin";
        _phoneNumber = data['accountModel']['account']['phoneNumber'] ??
            "Not Available";

        notifyListeners(); // Notify listeners about the updated data
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
