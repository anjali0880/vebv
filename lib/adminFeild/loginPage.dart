
import 'dart:convert';
import 'dart:io';
import 'package:check/adminFeild/AdminDashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart'; // Import the crypto package
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';


class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false; // State to manage loading indicator
  String? _errorMessage; // State to manage error messages

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to convert the password to MD5 hash
  String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Convert password to bytes
    final digest = md5.convert(bytes); // Create MD5 hash
    return digest.toString(); // Return the hash as a string
  }


  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      const String url = AuthApiConstants.adminLogin;
      var headers = {
        'Content-Type': 'application/json'
      };

      // Hash the password before sending
      String hashedPassword = _hashPassword(_passwordController.text);

      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode({
        "emailId": _emailController.text, // Use entered email
        "encodedPassword": hashedPassword, // Use hashed password
        "installToken": "13a9a764430dc3ba",
        "mode": "EMAIL"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        // Extract the accessCode from the response
        String accessCode = jsonResponse['accessCode'];

        // Save the accessCode in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('ad_login', accessCode);
        handleAuthorization();
        print('Access code saved: $accessCode');
      } else {
        print(response.reasonPhrase);
      }

      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }


  void handleAuthorization() async {
    String deviceModel = 'Unknown';
    String manufacturer = 'Unknown';
    String osVersion = 'Unknown';
    String mobilePlatform = 'Unknown';
    String appVersion = 'Unknown';
    var device = DeviceInfoPlugin();
    mobilePlatform = Platform.operatingSystem.toUpperCase();
    appVersion = (await PackageInfo.fromPlatform()).version;
    if (Platform.isAndroid) {
      var androidInfo = await device.androidInfo;
      deviceModel = androidInfo.model;
      manufacturer = androidInfo.manufacturer;
      osVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      var iosInfo = await device.iosInfo;
    }

    print('Device Model: $deviceModel');
    print('Manufacturer: $manufacturer');
    print('OS Version: $osVersion');
    print('Mobile Platform: $mobilePlatform');
    var headers = {
      'Content-Type': 'application/json'
    };
    const String url = AuthApiConstants.adminAuthorization;
    final prefs = await SharedPreferences.getInstance();
    var accessCode=prefs.getString('ad_login');
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "accessCode": accessCode,
      "deviceModel": deviceModel,
      "manufacturer": manufacturer,
      "osVersion": osVersion,
      "platform": mobilePlatform,
      "timeZone": "Asia/Calcutta",
      "version": appVersion,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
      );
    }
    else {
      print(response.reasonPhrase);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Row(
        children: [
          // Vertical divider
          Container(
            width: 1,
            height: double.infinity,
            color: Colors.white24,
          ),
          // Right side with login form
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: CircleAvatar(
                          radius: 75, // Size of the avatar
                          backgroundImage: AssetImage("assets/Dhundho Logo High Resolution.png"), // Avatar image
                          backgroundColor: Colors.transparent, // Transparent background
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Please login to admin dashboard.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Username',
                          prefixIcon: const Icon(Icons.email, color: Color(0xFF602851)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock, color: Color(0xFF602851)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        obscureText: !_isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      if (_errorMessage != null) ...[
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                      ],
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin, // Disable button when loading
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        )
                            : const Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
