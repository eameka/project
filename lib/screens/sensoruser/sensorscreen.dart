import 'package:ecowaste/widgets.dart/sensor_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
 // Location _locationController = new Location();
  static const LatLng _kGooglePlex = LatLng(6.6795024, -1.5734307);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Sensor map',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      drawer: const SensordrawerWidget(),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _kGooglePlex,
          zoom: 14.4746,
        ),
      ),
    );
  }


  /*Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
  }
  */
}
