import 'package:flutter/material.dart';

class CleanWaste extends StatefulWidget {
  const CleanWaste({super.key});

  @override
  State<CleanWaste> createState() => _CleanWasteState();
}

class _CleanWasteState extends State<CleanWaste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: ListView(
        children:<Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpansionTile(
              title: const Text("Cleanup order 1"),
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
              title: const Text("Cleanup Order 2"),
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