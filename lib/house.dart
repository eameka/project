import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecowaste/auth_service.dart";
import "package:ecowaste/houselogin.dart";
import "package:flutter/material.dart";

class House extends StatefulWidget {
  const House({super.key});

  @override
  State<House> createState() => _HouseState();
}

class _HouseState extends State<House> {

  final _auth = AuthService();
  final _db = FirebaseFirestore.instance;

   String _mobileNumber = " ";
   String _name = " ";
   String _mail = " ";
   

  @override
  void initState() {
    super.initState();
    _retrieveMobileNumber();
    _retrieveName();
    _retrieveMail();
  }

  @override
  void dispose() {
    super.dispose();
    _retrieveMobileNumber();
    _retrieveMail();
    _retrieveName();
  }

  _retrieveMobileNumber() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _mobileNumber = snapshot.get('Contact').toString();
      });
    }
  }

 _retrieveMail() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _mail = snapshot.get('Email').toString();
      });
    }
  }

  _retrieveName() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _name = snapshot.get('Household name').toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 108, 119, 108),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_name,
                        style: const TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Mobile Number'),
              subtitle:Text(_mobileNumber),
              leading: const Icon(Icons.phone),
              onTap: () {
                // Call API or perform action here
              },
            ),
           ListTile(
              title: const Text('E-mail'),
              subtitle:Text(_mail),
              leading: const Icon(Icons.mail),
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
