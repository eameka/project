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
  List<DocumentSnapshot> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Cleanup Orders'),
      ),
      body: _orders.isEmpty
         ? const Center(
              child: Text('No orders found'),
            )
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
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