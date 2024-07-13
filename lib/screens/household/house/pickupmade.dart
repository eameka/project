
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pickupmade extends StatefulWidget {
  Pickupmade(this.currentUser);
   User? currentUser = FirebaseAuth.instance.currentUser;
  
  @override
  State<Pickupmade> createState() => _PickupmadeState();
}

class _PickupmadeState extends State<Pickupmade> {
   CollectionReference pickup =
      FirebaseFirestore.instance.collection('pickup_orders');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Pickup orders requested', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        
      ),
    body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.currentUser?.uid)
              .collection('pickup_orders')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
        
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CupertinoActivityIndicator(
                        color: Color.fromARGB(255, 103, 196, 107),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        'Loading....',
                        style: TextStyle(
                          color: Color.fromARGB(255, 103, 196, 107),
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                );
              default:
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return ExpansionTile(
                      title: Text(document['Name']),
                      subtitle: Text(document['Contact']),
                      children: [
                        ListTile(
                          title: Text('Location: ${document['location']}'),
                        ),
                        ListTile(
                          title: Text('Waste type: ${document['Waste type']}'),
                        ),
                        ListTile(
                          title: Text(
                              'Available Days: ${document['Available Days']}'),
                        ),
                        ListTile(
                          title: Text(
                              'Available Companies: ${document['Available Companies']}'),
                        ),
                        ListTile(
                          title: Text(
                              'Selected company: ${document['Selected company']}'),
                        ),
                      ],
                    );
                  },
                );
            }
          },
        ),
      ), 
    );
  }
}