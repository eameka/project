import 'dart:convert';

import 'package:ecowaste/widgets.dart/sensor_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;
//import 'package:location/location.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  // Location _locationController = new Location();
  List<dynamic> _thingSpeakData = [];

  Future<List<dynamic>> fetchThingSpeakData() async {
    final apiKey = 'DZA4VZY1MOXZYRHJ';
    final channelId = '2632237';
    List<String> fieldIds = ['1', '2', '3'];

    List<dynamic> data = [];

    for (var fieldId in fieldIds) {
      final url =
          'https://api.thingspeak.com/channels/$channelId/fields/$fieldId.json?api_key=$apiKey&results=10';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        data.add(jsonData['feeds']);
      } else {
        throw Exception('Failed to load data from ThingSpeak');
      }
    }
    return data;
  }

  @override
  void initState() {
    super.initState();
    fetchThingSpeakData().then((data) {
      // Display the data in the card widgets
      setState(() {
        _thingSpeakData = data;
      });
    });
  }

  static const LatLng _kGooglePlex = LatLng(6.6795024, -1.5734307);
  final PanelController _panelController = PanelController();

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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _kGooglePlex,
              zoom: 14.4746,
            ),
          ),
          SlidingUpPanel(
            controller: _panelController,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            minHeight: MediaQuery.of(context).size.height * 0.1,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            body: Container(),
            panelBuilder: (sc) => _panelBuilder(sc),
          ),
        ],
      ),
    );
  }

  Widget _panelBuilder(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: [
          Center(
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Sensor Details',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0Xff0C2925),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                     _thingSpeakData.isNotEmpty
                        ? Text(
                            'Latitude: ${_thingSpeakData[0][0]['field1']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          )
                           : Text(
                            'Latitude: N/A',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                      _thingSpeakData.isNotEmpty
                        ? Text(
                            'Longitude: ${_thingSpeakData[0][0]['field2']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Longitude: N/A',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                        )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color(0Xff0C2925),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Waste Level',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Current Level: ${_thingSpeakData[0][2]}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
