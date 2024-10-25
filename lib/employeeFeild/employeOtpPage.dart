
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Home.dart';
import 'employeLoginPage.dart';
import 'employeeDashboard.dart';

class OTPInputPage extends StatefulWidget {
  @override
  _OTPInputPageState createState() => _OTPInputPageState();
}

class _OTPInputPageState extends State<OTPInputPage> {
  final TextEditingController _otpController = TextEditingController();

  Future<void> _submitOTP() async {
    final String otp = _otpController.text.trim();

    if (otp.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a valid OTP.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessCode = prefs.getString('accessCode');

    if (accessCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Access code not found. Please try again.')),
      );
      return;
    }

    final url = Uri.parse('https://v1.dhundhoo.com/auth/verifyotp');
    final Map<String, dynamic> body = {
      "accessCode": accessCode,
      "otp": otp,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successfully!')),
        );

        // Call the authorize method after OTP verification success
        await _authorize(accessCode);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskHomePage()),
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Failed to verify OTP')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _authorize(String accessCode) async {
    final url = Uri.parse('https://v1.dhundhoo.com/auth/authorize');
    final Map<String, dynamic> body = {
      "accessCode": accessCode,
      "deviceModel": "CPH2467",
      "manufacturer": "OnePlus",
      "osVersion": "13",
      "platform": "ANDROID",
      "timeZone": "Asia/Kolkata",
      "version": "1.3.6"
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response data: $data'); // Log the entire response


        final sessionCode = data['session'];
        if (sessionCode != null) {
          print('Session Code: $sessionCode'); // Print session code to console
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('sessionCode', sessionCode);
        }
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Authorization failed')),
        );
      }
    } catch (e) {
      print('Error during authorization: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during authorization: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text('dhundhoo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter OTP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _otpController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[700]!),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Submit OTP',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _submitOTP,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('OTP resent!')),
                    );
                  },
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MobileNumberInputScreen()),
                    );
                  },
                  child: Text(
                    'Change Number',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
