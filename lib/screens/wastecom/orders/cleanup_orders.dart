import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WasteCleanupOrdersPage extends StatefulWidget {
  const WasteCleanupOrdersPage({super.key});

  @override
  State<WasteCleanupOrdersPage> createState() => _WasteCleanupOrdersPageState();
}

class _WasteCleanupOrdersPageState extends State<WasteCleanupOrdersPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot>  _cleanupOrders = [];

  @override
  void initState() {
    super.initState();
    _loadCleanupOrders();
  }

 /* Future<void> _loadOrders() async {
    final currentUser = _auth.currentUser;
    if (currentUser!= null) {
      final querySnapshot = await _firestore
         .collection('users')
         .doc(currentUser.uid)
         .collection('cleanup_orders')
         .where('Selected company', isEqualTo: currentUser.uid)
         .get();
      setState(() {
        _orders = querySnapshot.docs;
      });
    }
  }
*/


Future<void> _loadCleanupOrders() async {
  final currentUser = _auth.currentUser;
  if (currentUser!= null) {
    final cleanupOrdersCollection = _firestore
       .collection('users')
       .doc(currentUser.uid)
       .collection('cleanup_orders');

    cleanupOrdersCollection
       .where('Selected company', isEqualTo: currentUser.uid)
       .get()
       .then((querySnapshot) {
           querySnapshot.docs.forEach((document) {
        _cleanupOrders.add(document);
      });
      setState(() {}); // Notify the framework that the widget needs to be rebuilt
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Cleanup Orders'),
      ),
      body:  _cleanupOrders.isEmpty
         ? const Center(
              child: Text('No orders found'),
            )
          : ListView.builder(
              itemCount:  _cleanupOrders.length,
              itemBuilder: (context, index) {
                final order =  _cleanupOrders[index];
                return Card(
                  child: ListTile(
                    title: Text(order['Name']),
                    subtitle: Text(order['location']),
                    trailing: Checkbox(
                      value: order['Completed']?? false,
                      onChanged: (value) {
                        _updateOrderStatus(order, value!);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _updateOrderStatus(DocumentSnapshot order, bool completed) async {
    await _firestore
       .collection('waste_company')
       .doc(order['Selected company'])
       .collection('wastecleanup_orders')
       .doc(order.id)
       .update({'Completed': completed});
  }
}