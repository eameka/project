
import 'package:ecowaste/screens/sensoruser/sensor/sensorpickup.dart';
import 'package:ecowaste/screens/sensoruser/sensorscreen.dart';
import 'package:flutter/material.dart';

class MySensorNavigate extends StatefulWidget {
  const MySensorNavigate({super.key});

  @override
  State<MySensorNavigate> createState() => _MySensorNavigateState();
}

class _MySensorNavigateState extends State<MySensorNavigate> {

 int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const SensorScreen(),
    const SensorPickup(),
   
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
        
          boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius:30,
              offset: const Offset(0, 20),
            ),
          ]
        ), 
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 103, 196, 107),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.maps_ugc, color: Colors.white,),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notification_add, color: Colors.white,),
                label: 'Order',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}