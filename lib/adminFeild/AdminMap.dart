import 'package:check/provider/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:check/adminFeild/AdminDashboard.dart';
import 'package:provider/provider.dart';

import '../provider/selected_task_provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Marker? _locationMarker;
  LatLng? _initialPosition;
  BitmapDescriptor? customMarkerIcon;
  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    fetchAdminInfo();
  }

  // Load custom marker icon
  Future<void> _loadCustomMarker() async {
    customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/marker_bus.png',
    );
  }

  Future<void> fetchAdminInfo() async {
    const String url = AdminApiConstants.latestUpdate;
    var request = http.Request('GET', Uri.parse('$url/866567069669373'));

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = json.decode(await response.stream.bytesToString());

        double latitude = responseData['latitude'];
        double longitude = responseData['longitude'];

        // Update marker position and camera location on the map
        _updateLocationMarker(latitude, longitude);
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Request failed with error: $e");
    }
  }

  void _updateLocationMarker(double latitude, double longitude) {
    final newPosition = LatLng(latitude, longitude);

    setState(() {
      _locationMarker = Marker(
        markerId: const MarkerId('admin_location'),
        position: newPosition,
        icon: customMarkerIcon ??
            BitmapDescriptor.defaultMarker, // Use custom icon if loaded
        infoWindow: InfoWindow(
          title: 'Device Location',
          snippet: 'Lat: $latitude, Long: $longitude',
        ),
      );
      _initialPosition = newPosition;
    });
    mapController.animateCamera(CameraUpdate.newLatLng(newPosition));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_initialPosition != null) {
      mapController.animateCamera(CameraUpdate.newLatLng(_initialPosition!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTask =
        Provider.of<SelectedTaskProvider>(context).selectedTask;
    print(selectedTask);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Component'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDashboardScreen(),
              ),
            );
          },
        ),
      ),
      body: _initialPosition == null
          ? const Center(
              child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition!,
                zoom: 10,
              ),
              markers: _locationMarker != null ? {_locationMarker!} : {},
            ),
    );
  }
}
