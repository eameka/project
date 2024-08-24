import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowaste/screens/sensoruser/sensor/requestform.dart';
import 'package:ecowaste/screens/sensoruser/sensorscreen.dart';
import 'package:ecowaste/widgets.dart/sensor_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SensorPickup extends StatefulWidget {
  const SensorPickup({super.key});

  @override
  State<SensorPickup> createState() => _SensorPickupState();
}

class _SensorPickupState extends State<SensorPickup> {
   int pickupRequestsCount = 0;
  bool isLoadingRequests = true;

  @override
  void initState() {
    super.initState();
    _fetchRequestsCount();
  }

Future<void> _fetchRequestsCount() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final pickupSnapshot = await FirebaseFirestore.instance
            .collection('Sensor_Household')
            .doc(user.uid)
            .collection('sensor pickup_orders')
            .get();
        

        setState(() {
          pickupRequestsCount = pickupSnapshot.docs.length;
          isLoadingRequests = false;
        });
      }
    } catch (e) {
      print("Error fetching requests count: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 103, 196, 107),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SensorScreen(),
                ));
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Tiny steps today,trash free tomorrow',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
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
                                    height:  120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color.fromARGB(
                                            37, 142, 250, 155)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        isLoadingRequests
                                            ? CupertinoActivityIndicator()
                                            : Text(
                                                "$pickupRequestsCount",
                                                style: TextStyle(
                                                    fontSize: 60,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ],
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
                 
                  InkWell(
                      onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => PickupForm(),
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
                                        image: AssetImage('assets/pickup.jpeg'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Pickup Requests',
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
            ),
          ],
        ),
      ),
    );
  }
}
