import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../provider/constants.dart';
import 'AdminDashboard.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String avatarUrl = "assets/avatar1.png";
  String email = "I am Admin";
  String firstName = " ";
  String lastName = " ";
  String phoneNumber = "Not Available";

  @override
  void initState() {
    super.initState();
    fetchAdminInfo();
  }

  Future<void> fetchAdminInfo() async {
    const String url = AuthApiConstants.adminInfo;
    var headers = {
      'x-dhundhoo-session': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbi50bWtAcGViYmxlY3JlZWtsaWZlc2Nob29sLmluIiwicm9sZSI6IkFETUlOIiwib3JnSGFuZGxlIjoiZGRiZGFhMmUtZmJiYi00ZjNjLWEyODAtZmNmYmJhY2QzZTM1IiwiYWNjZXNzQ29kZSI6ImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUowYjJ0bGJpSTZJbUptWWpJMU9XTTBMVGM1T0dJdE5HVmpaQzA1TnpRM0xUVTFNemcxWXpRMllUUmlPQ0lzSW5ScGJXVnpkR0Z0Y0NJNk1UY3lPVGswTnpVNE5ESXpOSDAuLXBmRTJWNGhtYlgwRFBoa3o1N2NIZHpPZ211TzFZUzBDVkUwdU8wcEhLSSIsInRpbWVab25lIjoiVVRDKzA1OjMwIiwidHlwZSI6Ik9SRyIsInZlcnNpb24iOiIwLjIuMCIsInBsYXRmb3JtIjoiV0VCIiwiZXhwaXJlc0F0IjoxNzMwMDMzOTk4ODk3fQ.XEuIY-lqpWp52pIFqnT2ZD6y5d1siGqZB5K_XCUGT-0', // Replace with your session token
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        avatarUrl = data['accountModel']['account']['avatar'] ?? "assets/avatar1.png";
        firstName = data['accountModel']['account']['firstName'] ?? " ";
        lastName = data['accountModel']['account']['lastName'] ?? " ";
        email = data['accountModel']['account']['emailId'] ?? "I am Admin";
        phoneNumber = data['accountModel']['account']['phoneNumber'] ?? "Not Available";
      });
    } else {
      print("Error: ${response.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('My Profile'),
        backgroundColor: Colors.grey[850],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDashboardScreen(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Edit profile action
            },
          ),
        ],
      ),
      body: Center( // Use Center to align contents
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[700],
                  backgroundImage: NetworkImage(avatarUrl), // Display avatar
                  child: avatarUrl == "assets/avatar1.png"
                      ? Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[700],
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              '$firstName $lastName', // Display dynamic name
              style: TextStyle(
                color: Colors.orange[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Card(
                    color: Colors.grey[800],
                    child: ListTile(
                      leading: Icon(Icons.phone, color: Colors.white),
                      title: Text(
                        phoneNumber, // Display dynamic phone number
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.grey[800],
                    child: ListTile(
                      leading: Icon(Icons.email, color: Colors.white),
                      title: Text(
                        email, // Display dynamic email
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


