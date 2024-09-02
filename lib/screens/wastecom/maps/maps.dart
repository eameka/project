import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecowaste/widgets.dart/company_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMaps extends StatefulWidget {
  const MyMaps({super.key});

  @override
  State<MyMaps> createState() => _MyMapsState();
}

class _MyMapsState extends State<MyMaps> {
  static const LatLng _kGooglePlex = LatLng(6.6795024, -1.5734307);
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  CameraPosition? _currentCameraPosition;

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    _markers.add(
      Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(6.6933, -1.5642), // Brunei
        infoWindow: InfoWindow(title: 'Brunei'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('marker2'),
        position: LatLng(6.6873, -1.5667), // KNUST police station
        infoWindow: InfoWindow(title: 'KNUST police station'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('marker3'),
        position: LatLng(6.6842, -1.5719), // Sun city
        infoWindow: InfoWindow(title: 'Sun city'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('marker4'),
        position: LatLng(6.6803, -1.5744), // Glokezz Apartments
        infoWindow: InfoWindow(title: 'Glokezz Apartments'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('marker5'),
        position: LatLng(6.6833, -1.5733), // CSIR Kumasi
        infoWindow: InfoWindow(title: 'CSIR Kumasi'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const CompanyDrawer(),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _kGooglePlex,
              zoom: 14.4746,
            ),
            onCameraMove: (CameraPosition cameraPosition) {
              _currentCameraPosition = cameraPosition;
            },
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: _markers,
            polylines: _polylines,
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searchLocation();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _searchLocation() async {
    final String query = _searchController.text;
    final GoogleMapController? controller = _mapController;
    if (controller != null) {
      final LatLngBounds bounds = await controller.getVisibleRegion();

      final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=AIzaSyB2Xp6uM1mERY6cXHnUbQrflvXTeobAjHE',
      ));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final places = jsonData['results'];

        if (places.isNotEmpty) {
          final place = places.first;
          final LatLng location = LatLng(place['geometry']['location']['lat'],
              place['geometry']['location']['lng']);

          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: location,
                zoom: 15,
              ),
            ),
          );

          _calculateShortestPath(location);
        }
      } else {
        print('Error searching location: ${response.statusCode}');
      }
    }
  }

  void _calculateShortestPath(LatLng destination) async {
    final GoogleMapController? controller = _mapController;
    if (controller != null && _currentCameraPosition != null) {
      final LatLng currentLocation = _currentCameraPosition!.target;

      final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=AIzaSyB2Xp6uM1mERY6cXHnUbQrflvXTeobAjHE',
      ));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final routes = jsonData['routes'];

        if (routes.isNotEmpty) {
          final route = routes.first;
          final polylinePoints = route['overview_polyline']['points'];

          final polyline = Polyline(
            polylineId: PolylineId('route'),
            points: polylinePoints
                .map((point) => LatLng(point['lat'], point['lng']))
                .toList(),
            color: Colors.blue,
            width: 5,
          );

          setState(() {
            _polylines.add(polyline);
          });
        }
      }
    }
  }
}
