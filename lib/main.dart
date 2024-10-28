import 'package:check/Home.dart';
import 'package:check/adminFeild/loginPage.dart';
import 'package:check/adminFeild/AdminDashboard.dart'; // Your MobileDashboardScree
import 'package:check/provider/adminInfoProvider.dart';
import 'package:check/provider/selected_task_provider.dart';
import 'package:check/provider/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => SelectedTaskProvider()),

      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home', // Set initial route to the login page
      routes: {
      //  '/login': (context) => const LoginPage(),
        '/home': (context) => const DashboardSelectionScreen(),

        // Route for LoginPage
        '/dashboard': (context) => AdminDashboardScreen(), // Route for MobileDashboardScreen
      // Route for MobileDashboardScreen
      },
    );
  }
}