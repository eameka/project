import 'package:flutter/material.dart';

class PickupWaste extends StatefulWidget {
  const PickupWaste({super.key});

  @override
  State<PickupWaste> createState() => _PickupWasteState();
}

class _PickupWasteState extends State<PickupWaste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children:<Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpansionTile(
              title: const Text("Pickup orders 1"),
              collapsedIconColor:Colors.white,
              collapsedTextColor:Colors.white,
              collapsedBackgroundColor: Colors.green,
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.black),
              ),
              children:<Widget>[
                ListTile(
                  title: Text("Zoomlion company"),
                ),
              ],
            ),
          ),
           
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpansionTile(
              title: const Text("Pickup orders 2"),
              collapsedIconColor:Colors.white,
              collapsedTextColor:Colors.white,
              collapsedBackgroundColor: Colors.green,
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.black),
              ),
              children:<Widget>[
                ListTile(
                  title: Text("SmartWaste"),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}