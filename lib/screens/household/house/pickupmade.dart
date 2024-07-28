import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pickupmade extends StatefulWidget {
  final User currentUser;
  Pickupmade({super.key, required this.currentUser});

  @override
  State<Pickupmade> createState() => _PickupmadeState();
}

class _PickupmadeState extends State<Pickupmade> {
  Future<String> getCompanyName(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('waste_company')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['company_name'];
    } else {
      return 'Unknown Company';
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference requestsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser.uid)
        .collection('pickup_orders');

    return Scaffold(
        appBar: AppBar(
            elevation: 15.0,
            backgroundColor: const Color.fromARGB(255, 103, 196, 107),
            title: const Text(
              'Request Waste Pickup',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
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
        body: StreamBuilder(
            stream: requestsCollection
                .orderBy('requesttimestamp', descending: true)
                .snapshots(),
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

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    'No requests found',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var request = snapshot.data!.docs[index];
                  bool isPickedUp = request['isPickedUp'];
                  Timestamp requesttimestamp = request['requesttimestamp'];
                  DateTime dateTime = requesttimestamp.toDate();
                  String formattedDate =
                      DateFormat('dd-MM-yyyy - hh:mm a').format(dateTime);

                  return FutureBuilder(
                    future: getCompanyName(request['Selected company']),
                    builder:
                        (context, AsyncSnapshot<String> companyNameSnapshot) {
                      if (companyNameSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return ListTile(
                          title: Text(request['Quantity']),
                          subtitle: const Text('Loading company...'),
                          trailing: Text(
                            isPickedUp ? 'Pickup Completed' : 'Pickup Pending',
                            style: TextStyle(
                              color: isPickedUp ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      if (companyNameSnapshot.hasError) {
                        return ListTile(
                          title: Text(request['Quantity']),
                          subtitle: const Text('Error loading company'),
                          trailing: Text(
                            isPickedUp ? 'Pickup Completed' : 'Pickup Pending',
                            style: TextStyle(
                              color: isPickedUp ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      return _buildRequestTile(
                        quantity: request['Quantity'],
                        companyName:
                            companyNameSnapshot.data ?? 'Unknown Company',
                        requestTime: formattedDate,
                        isPickedUp: isPickedUp,
                      );
                    },
                  );
                },
              );
            }));
  }
}

Widget _buildRequestTile({
  required String quantity,
  required String companyName,
  required String requestTime,
  required bool isPickedUp,
}) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            quantity,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            companyName,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Request Time: $requestTime',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8),
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
        ],
      ),
    ),
  );
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
