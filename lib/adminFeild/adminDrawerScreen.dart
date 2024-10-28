import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Home.dart';
import '../provider/constants.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  String avatarUrl = "assets/avatar1.png";
  String email = "I am Admin";
  String fristName = " ";
  String LastName = " ";
  String phoneNumber = "Not Available";

  @override
  void initState() {
    super.initState();
    fetchAdminInfo();
  }

  Future<void> fetchAdminInfo() async {
    const String url = AuthApiConstants.adminInfo;
    var headers = {
      'x-dhundhoo-session':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbi50bWtAcGViYmxlY3JlZWtsaWZlc2Nob29sLmluIiwicm9sZSI6IkFETUlOIiwib3JnSGFuZGxlIjoiZGRiZGFhMmUtZmJiYi00ZjNjLWEyODAtZmNmYmJhY2QzZTM1IiwiYWNjZXNzQ29kZSI6ImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUowYjJ0bGJpSTZJbUptWWpJMU9XTTBMVGM1T0dJdE5HVmpaQzA1TnpRM0xUVTFNemcxWXpRMllUUmlPQ0lzSW5ScGJXVnpkR0Z0Y0NJNk1UY3lPVGswTnpVNE5ESXpOSDAuLXBmRTJWNGhtYlgwRFBoa3o1N2NIZHpPZ211TzFZUzBDVkUwdU8wcEhLSSIsInRpbWVab25lIjoiVVRDKzA1OjMwIiwidHlwZSI6Ik9SRyIsInZlcnNpb24iOiIwLjIuMCIsInBsYXRmb3JtIjoiV0VCIiwiZXhwaXJlc0F0IjoxNzMwMDMzOTk4ODk3fQ.XEuIY-lqpWp52pIFqnT2ZD6y5d1siGqZB5K_XCUGT-0'
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        avatarUrl =
            data['accountModel']['account']['avatar'] ?? "assets/avatar1.png";

        fristName = data['accountModel']['account']['firstName'] ?? " ";
        LastName = data['accountModel']['account']['lastName'] ?? " ";
        email = data['accountModel']['account']['emailId'] ?? "I am Admin";
        phoneNumber =
            data['accountModel']['account']['phoneNumber'] ?? "Not Available";
      });
    } else {
      print("Error: ${response.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(avatarUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          '${fristName} ${LastName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        phoneNumber,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Reports'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardSelectionScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
