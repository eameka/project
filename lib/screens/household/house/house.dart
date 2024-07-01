import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecowaste/screens/household/auth/auth_service.dart";
import "package:ecowaste/screens/household/profile/houselogin.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class House extends StatefulWidget {
  const House({super.key});

  @override
  State<House> createState() => _HouseState();
}

class _HouseState extends State<House> {

  final _auth = AuthService();
   
 /*   final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  Map<String, dynamic>? userProfile;

  
   

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    if (user != null) {
      fetchUserProfile();
    }
  }


 Future<void> fetchUserProfile() async {
    String uid = user!.uid;
    Map<String, dynamic>? profile = await getUserProfile(uid);
    setState(() {
      userProfile = profile;
    });
  }

    Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc('id').get();
    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }
*/
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
                  Text("",
                      style: const TextStyle(fontSize: 20, color: Colors.black)),
                ],
              ),
            ),
            ListTile(
              title: const Text('Mobile Number'),
              subtitle:Text(""),
              leading: const Icon(Icons.phone),
              onTap: () {
                // Call API or perform action here
              },
            ),
           ListTile(
              title: const Text('E-mail'),
              subtitle:Text(""),
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
