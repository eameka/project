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
             onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
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

      // You need to use the Google Places API to search for places
      // You can't use the Google Maps Flutter package to search for places
      // You need to make a separate API request to the Google Places API
      // Here's an example using the http package
      final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=AIzaSyB2Xp6uM1mERY6cXHnUbQrflvXTeobAjHE',
      ));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final places = jsonData['results'];

        if (places.isNotEmpty) {
          final place = places.first;
          final LatLng location = LatLng(place['geometry']['location']['lat'], place['geometry']['location']['lng']);

          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: location,
                zoom: 15,
              ),
            ),
          );
        }
      }
    }
  }

}
