import 'package:ecowaste/auth_service.dart';
import 'package:ecowaste/houselogin.dart';
import 'package:flutter/material.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {

  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Request', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color:Colors.white,
        ),
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
                  Text('Dojo',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
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
              title: const Text('Payment'),
              leading: const Icon(Icons.wallet),
              onTap: () {
                // Call API or perform action here
              },
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                // Call API or perform action here
                 await _auth.signout();
                 Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHouseLogin(),
          )); 
              },
            ),
          ],
        ),
      ),
      body:Container(),
    );
  }
}
