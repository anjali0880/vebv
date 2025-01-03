import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:check/Home.dart';

import 'package:check/adminFeild/AdminDashboard.dart'; // Your MobileDashboardScree

import 'package:check/provider/employee_task_provider.dart';
import 'package:check/provider/selected_employeetask_Provider.dart';

import 'package:check/provider/selected_task_provider.dart';
import 'package:check/provider/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'employeeFeild/employeemap.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundLocationTrackerManager.initialize(
    backgroundCallback,
    config: const BackgroundLocationTrackerConfig(
      loggingEnabled: true,
      androidConfig: AndroidConfig(
        notificationIcon: 'explore',
        trackingInterval: Duration(seconds: 4),
        distanceFilterMeters: null,
      ),
      iOSConfig: IOSConfig(
        activityType: ActivityType.FITNESS,
        distanceFilterMeters: null,
        restartAfterKill: true,
      ),
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => SelectedTaskProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeTaskProvider()),
        ChangeNotifierProvider(create: (_) => SelectedEmployeeTaskProvider()),
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