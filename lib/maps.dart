
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMaps extends StatefulWidget {
  const MyMaps({super.key});

  @override
  State<MyMaps> createState() => _MyMapsState();
}

class _MyMapsState extends State<MyMaps> {
static const LatLng _kGooglePlex = LatLng(6.6795024, -1.5734307);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
    target: _kGooglePlex,
    zoom: 14.4746,),
      ),
    );
  }
}