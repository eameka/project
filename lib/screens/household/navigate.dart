import 'package:ecowaste/screens/household/educate/educate.dart';
import 'package:ecowaste/screens/household/house/house.dart';
import 'package:ecowaste/screens/household/request/request.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const House(),
    const Notify(),
    const Educate(),
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
                  icon: Icon(Icons.home, color: Colors.white,),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notification_add, color: Colors.white,),
                  label: 'Request',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school, color: Colors.white,),
                  label: 'Educate',
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
