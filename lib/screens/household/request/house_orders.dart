import 'package:flutter/material.dart';

class HouseOrders extends StatefulWidget {
  const HouseOrders({super.key});

  @override
  State<HouseOrders> createState() => _HouseOrdersState();
}

class _HouseOrdersState extends State<HouseOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children:<Widget> [
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpansionTile(
              title: const Text("Order 1"),
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
        ],
      ),
    );
  }
}