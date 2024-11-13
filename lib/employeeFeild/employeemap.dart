import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/selected_employeetask_Provider.dart';

@pragma('vm:entry-point')
void backgroundCallback() {
  BackgroundLocationTrackerManager.handleBackgroundUpdated(
        (data) async => Repo().update(data),
  );
}

class EmployeeMapComponent extends StatefulWidget {
  @override
  _EmployeeMapComponentState createState() => _EmployeeMapComponentState();
}

class _EmployeeMapComponentState extends State<EmployeeMapComponent> {
  bool isTracking = false;
  Timer? _timer;
  List<String> _locations = [];
  GoogleMapController? _mapController;
  List<Marker> _markers = [];
  BitmapDescriptor? _customMarker;
  BitmapDescriptor? _customTicketMarker;

  @override
  void initState() {
    super.initState();
    _getTrackingStatus();
    _startLocationsUpdatesStream();
    _loadCustomMarkers();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedEmployeeTask =
        context.watch<SelectedEmployeeTaskProvider>().selectedEmployeeTask;

    if (selectedEmployeeTask == null) {
      return const Scaffold(
        body: Center(
          child: Text('No employee task selected'),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Location Tracker'),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: Icon(
                isTracking ? Icons.stop : Icons.play_arrow,
                color: isTracking ? Colors.red : Colors.green,
              ),
              onPressed: _toggleTracking,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) => _mapController = controller,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0.0, 0.0),
                  zoom: 2,
                ),
                markers: Set<Marker>.of(_markers),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleTracking() async {
    if (isTracking) {
      await _stopTracking();
    } else {
      await _startTracking();
    }
    setState(() => isTracking = !isTracking);
  }

  Future<void> _startTracking() async {
    await _requestPermissions();
    await BackgroundLocationTrackerManager.startTracking();
    print('Tracking started');
  }

  Future<void> _stopTracking() async {
    await LocationDao().clear();
    await _getLocations();
    await BackgroundLocationTrackerManager.stopTracking();
    print('Tracking stopped');
  }

  Future<void> _getTrackingStatus() async {
    isTracking = await BackgroundLocationTrackerManager.isTracking();
    setState(() {});
  }

  Future<void> _requestPermissions() async {
    await Permission.location.request();
    await Permission.notification.request();
  }

  Future<void> _getLocations() async {
    final locations = await LocationDao().getLocations();
    setState(() {
      _locations = locations;
    });
    _updateMapMarkers();
  }

  void _startLocationsUpdatesStream() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 250),
          (timer) => _getLocations(),
    );
  }

  Future<void> _loadCustomMarkers() async {
    _customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/marker_bus.png',
    );

    _customTicketMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/marker_stop.png',
    );

  }

  void _updateMapMarkers() {
    _markers.clear();

    // Add current tracking location markers
    for (var location in _locations) {
      final parts = location.split(',');
      if (parts.length == 2) {
        final lat = double.tryParse(parts[0].split(' ').last) ?? 0.0;
        final lon = double.tryParse(parts[1]) ?? 0.0;
        final marker = Marker(
          markerId: MarkerId(location),
          position: LatLng(lat, lon),
          icon: _customMarker ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Tracked Location'),
        );
        _markers.add(marker);
      }
    }

    // Add markers for tickets in the selected task
    final selectedEmployeeTask =
        context.read<SelectedEmployeeTaskProvider>().selectedEmployeeTask;
    if (selectedEmployeeTask != null) {
      for (var ticket in selectedEmployeeTask['tickets']) {
        final lat = ticket['latitude'];
        final lon = ticket['longitude'];
        final marker = Marker(
          markerId: MarkerId(ticket['ticketName']),
          position: LatLng(lat, lon),
          icon: _customTicketMarker ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: ticket['ticketName']),
          onTap: () => _showTicketDetails(ticket),
        );
        _markers.add(marker);
      }
    }

    if (_markers.isNotEmpty) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(_markers.last.position),
      );
    }
  }

  void _showTicketDetails(Map<String, dynamic> ticket) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticket['ticketName'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Latitude: ${ticket['latitude']}'),
              Text('Longitude: ${ticket['longitude']}'),
              Text('Status: ${ticket['status']}'),
              Text('Created At: ${ticket['createdAt']}'),
              Text('Updated At: ${ticket['updatedAt']}'),
            ],
          ),
        );
      },
    );
  }
}

class Repo {
  static Repo? _instance;

  Repo._();

  factory Repo() => _instance ??= Repo._();

  Future<void> update(BackgroundLocationUpdateData data) async {
    final text = 'Location Update: Lat: ${data.lat} Lon: ${data.lon}';
    print(text);
    sendNotification(text);
    await LocationDao().saveLocation(data);
  }
}

class LocationDao {
  static const _locationsKey = 'background_updated_locations';
  static const _locationSeparator = '-/-/-/';

  static LocationDao? _instance;

  LocationDao._();

  factory LocationDao() => _instance ??= LocationDao._();

  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async =>
      _prefs ??= await SharedPreferences.getInstance();

  Future<void> saveLocation(BackgroundLocationUpdateData data) async {
    final locations = await getLocations();
    locations.add(
        '${DateTime.now().toIso8601String()} ${data.lat},${data.lon}');
    await (await prefs)
        .setString(_locationsKey, locations.join(_locationSeparator));
  }

  Future<List<String>> getLocations() async {
    final prefs = await this.prefs;
    await prefs.reload();
    final locationsString = prefs.getString(_locationsKey);
    return locationsString?.split(_locationSeparator) ?? [];
  }

  Future<void> clear() async => (await prefs).clear();
}

void sendNotification(String text) {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('app_icon'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    ),
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      print('Notification clicked: ${response.payload}');
    },
  );

  flutterLocalNotificationsPlugin.show(
    Random().nextInt(9999),
    'Location Update',
    text,
    const NotificationDetails(
      android: AndroidNotificationDetails('tracking_notification', 'Tracking'),
      iOS: DarwinNotificationDetails(),
    ),
  );
}
