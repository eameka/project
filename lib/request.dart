import 'package:cloud_firestore/cloud_firestore.dart';
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
        _mobileNumber = snapshot.get('contact').toString();
      });
    }
  }

   _retrieveName() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _name = snapshot.get('name').toString();
      });
    }
  }

 _retrieveMail() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _mail = snapshot.get('email').toString();
      });
    }
  }

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
           DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 202, 255, 204),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                  Text(_name,
                      style: const TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
            ),
            ListTile(
              title: const Text('Mobile Number'),
              subtitle: Text(_mobileNumber),
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
      body:Column(
           mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(35), bottomRight: Radius.circular(35)),
              color: Colors.green,
            ),
           ),
           SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/pickup.jpeg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                     const Center(
                       child: Padding(
                         padding: EdgeInsets.all(8.0),
                         child: Text('Request Pickup'),
                       ),
                     ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/cleanup.jpeg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                     const Center(
                       child: Padding(
                         padding: EdgeInsets.all(8.0),
                         child: Text('Request Cleanup'),
                       ),
                     ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/orders.jpeg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                     const Center(
                       child: Padding(
                         padding: EdgeInsets.all(8.0),
                         child: Text('Orders'),
                       ),
                     ),
                  ],
                ),
              ),
             ],
          ),
          ],
          ),
    );
  }
}
