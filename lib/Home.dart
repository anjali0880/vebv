
import 'package:check/adminFeild/loginPage.dart';
import 'package:check/employeeFeild/employeLoginPage.dart';
import 'package:check/employeeFeild/employeeDashboard.dart';
import 'package:check/adminFeild/AdminDashboard.dart';
import 'package:flutter/material.dart';

class DashboardSelectionScreen extends StatelessWidget {
  const DashboardSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[900], // Darker background for a modern look
      appBar: AppBar(
        title: const Text('Login as you Are?'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
       // automaticallyImplyLeading: false,

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Corrected User Avatar using CircleAvatar
              const CircleAvatar(
                radius: 75, // Size of the avatar
                backgroundImage: AssetImage("assets/Dhundho Logo High Resolution.png"), // Avatar image
                backgroundColor: Colors.transparent, // Transparent background
              ),
              const SizedBox(height: 20), // Space between avatar and title
              const Text(
                'Welcome, User!',
                style: TextStyle(
                  color: Colors.white, // White text on dark background
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              _buildCustomButton(
                context: context,
                label: 'Admin Dashboard',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                    builder: (context) =>  AdminDashboardScreen(),
                     // builder: (context) => AdminLoginScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildCustomButton(
                context: context,
                label: 'Employee Dashboard',
                onPressed: () {
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => MobileNumberInputScreen()),
                    MaterialPageRoute(builder: (context) => TaskHomePage()),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50, // Height of the button
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[700], // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18, // Larger font size
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}




