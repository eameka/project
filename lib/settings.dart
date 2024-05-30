import 'package:ecowaste/educate.dart';
import 'package:ecowaste/notify.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Settings(),
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 202, 255, 204),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Dojo',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Mobile Number'),
              subtitle: const Text('0507971715'),
              leading: const Icon(Icons.phone),
              onTap: () {
                // Call API or perform action here
              },
            ),
            ListTile(
                title: const Text('Selected Waste Company'),
                subtitle: const Text('EcoWaste Company'),
                leading: const Icon(Icons.person),
                onTap: () {
                  // Call API or perform action here
                }),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () {
                // Call API or perform action here
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        backgroundColor: const Color.fromARGB(255, 202, 255, 204),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_sharp),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Notify',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Educate',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
