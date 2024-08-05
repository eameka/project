import 'dart:developer';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecowaste/screens/wastecom/navigatewaste.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class WasteCleanupOrdersPage extends StatefulWidget {
  const WasteCleanupOrdersPage({super.key});

  @override
  State<WasteCleanupOrdersPage> createState() => _WasteCleanupOrdersPageState();
}

class _WasteCleanupOrdersPageState extends State<WasteCleanupOrdersPage> {
  final _amount = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> getCleanupOrders() async {
    List<Map<String, dynamic>> cleanupOrders = [];
    final usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (var userDoc in usersSnapshot.docs) {
      final cleanupOrdersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userDoc.id)
          .collection('cleanup_orders')
          .where('Selected company', isEqualTo: _auth.currentUser?.email)
          .get();

      for (var orderDoc in cleanupOrdersSnapshot.docs) {
        cleanupOrders.add({
          'userId': userDoc.id,
          'householdName': userDoc.data()['name'],
          'userContact': userDoc.data()['contact'],
          'orderId': orderDoc.id,
          ...orderDoc.data(),
        });
      }
    }

    return cleanupOrders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 15.0,
          backgroundColor: const Color.fromARGB(255, 103, 196, 107),
          title: const Text('Waste Cleanup Orders'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
          body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getCleanupOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'An error occurred while fetching data',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No orders found',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          List<Map<String, dynamic>> cleanupOrders = snapshot.data!;

          return ListView.builder(
            itemCount: cleanupOrders.length,
            itemBuilder: (context, index) {
              var order = cleanupOrders[index];
              bool isPickedUp = order['isPickedUp'];
              Timestamp timestamp = order['requesttimestamp'];
              DateTime dateTime = timestamp.toDate();
              String formattedDate =
                  DateFormat('yyyy-MM-dd – hh:mm a').format(dateTime);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quantity: ${order['Quantity']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Household Name: ${order['householdName']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'User Contact: ${order['userContact']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Location: ${order['location']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Available Day: ${order['Available Days']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Available Time: ${order['Available Times']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Request Time: $formattedDate',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          isPickedUp ? 'Pickup Completed' : 'Pickup Pending',
                          style: TextStyle(
                            color: isPickedUp ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: isPickedUp ? 8 : 28),
                      !isPickedUp
                          ? ElevatedButton(
                               onPressed: (){},
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0Xff0C2925),
                                ),
                              ),
                              child: const Text(
                                'Mark as completed',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    
    );
  }
}
