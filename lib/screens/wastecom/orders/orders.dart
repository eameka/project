import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowaste/screens/wastecom/orders/cleanup_orders.dart';
import 'package:ecowaste/screens/wastecom/orders/pickup_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Future<double> getSumOfAmounts() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final _currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    final QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(_currentUserEmail)
        .collection('pickup_orders')
        .where('Selected company', isEqualTo: _currentUserEmail)
        .where('isPickedUp', isEqualTo: true)
        .get();

    double sum = 0.0;
    snapshot.docs.forEach((doc) {
      sum += (doc.data() as Map<String, dynamic>)['amount'];
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 103, 196, 107),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Cash In',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              FutureBuilder<double>(
                future: getSumOfAmounts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Balance: GH¢ ${snapshot.data!.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    );
                  } else {
                    return const Text(
                      'Loading wallet amount...',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WastePickupOrdersPage(),
                    ),
                  );
                },
                child: Card(
                  elevation: 1,
                  color: Colors.white,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage('assets/garbaget.jpeg'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Pickup Orders',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WasteCleanupOrdersPage(),
                ),
              );
            },
           child: Card(
              elevation: 1,
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.40,
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage('assets/clean.jpeg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Cleanup orders',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
          ),
        ],
      ),
    );
  }
}
