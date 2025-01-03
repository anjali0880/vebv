import 'dart:convert';
import 'package:check/Home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/constants.dart';
import 'package:http/http.dart' as http;

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const CustomDrawerHeader(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text('My Tasks'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Map'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
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
                MaterialPageRoute(builder: (context) => const DashboardSelectionScreen()),
              );
            },
          ),
          // Use SizedBox instead of Spacer
          const SizedBox(height: 300),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Text(
                  'We are social @',
                  style: TextStyle(color: Colors.black,fontSize: 20),
                ),
                const Spacer(),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.black),
                  onPressed: () async {
                    const url = 'https://m.facebook.com/dhundhoo';
                    final Uri uri = Uri.parse(url); // Convert String to Uri

                    if (await canLaunchUrl(uri)) { // Use the Uri object
                      await launchUrl(uri); // Use the Uri object
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.black),
                  onPressed: () async {
                    const url = 'https://m.facebook.com/dhundhoo';
                    final Uri uri = Uri.parse(url);

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({super.key});

  @override
  _CustomDrawerHeaderState createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {

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
      'x-dhundhoo-session': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJhZG1pbi50bWtAcGViYmxlY3JlZWtsaWZlc2Nob29sLmluIiwicm9sZSI6IkFETUlOIiwib3JnSGFuZGxlIjoiZGRiZGFhMmUtZmJiYi00ZjNjLWEyODAtZmNmYmJhY2QzZTM1IiwiYWNjZXNzQ29kZSI6ImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUowYjJ0bGJpSTZJbUptWWpJMU9XTTBMVGM1T0dJdE5HVmpaQzA1TnpRM0xUVTFNemcxWXpRMllUUmlPQ0lzSW5ScGJXVnpkR0Z0Y0NJNk1UY3lPVGswTnpVNE5ESXpOSDAuLXBmRTJWNGhtYlgwRFBoa3o1N2NIZHpPZ211TzFZUzBDVkUwdU8wcEhLSSIsInRpbWVab25lIjoiVVRDKzA1OjMwIiwidHlwZSI6Ik9SRyIsInZlcnNpb24iOiIwLjIuMCIsInBsYXRmb3JtIjoiV0VCIiwiZXhwaXJlc0F0IjoxNzMwMDMzOTk4ODk3fQ.XEuIY-lqpWp52pIFqnT2ZD6y5d1siGqZB5K_XCUGT-0'
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        avatarUrl = data['accountModel']['account']['avatar'] ??
            "assets/avatar1.png";
        fristName=data['accountModel']['account']['firstName'] ?? " ";
        LastName=data['accountModel']['account']['lastName'] ?? " ";
        email = data['accountModel']['account']['emailId'] ?? "I am Admin";
        phoneNumber = data['accountModel']['account']['phoneNumber'] ??
            "Not Available";
      });
    } else {
      print("Error: ${response.reasonPhrase}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.grey[800],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: avatarUrl.startsWith('http')
                ? NetworkImage(avatarUrl)
                : AssetImage(avatarUrl) as ImageProvider,
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$fristName $LastName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
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
    );
  }
}
