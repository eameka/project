import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowaste/screens/household/request/requestcleanup.dart';
import 'package:ecowaste/screens/household/request/requestpickup.dart';

import 'package:flutter/material.dart';

import '../../../widgets.dart/drawer_widget.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  String? _timeOfDay;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Request', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 103, 196, 107),
        iconTheme: const IconThemeData(
          color: Colors.white,
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
                      'Reduce, Reuse, Recycle',
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
      drawer: const drawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  // showModalBottomSheet(
                  //   context: context,
                  //   isScrollControlled: true, // make the sheet scrollable
                  //   builder: (context) {
                  //     TimeOfDay timeOfDay = const TimeOfDay(hour: 8, minute: 0);
                  //     return FractionallySizedBox(
                  //       heightFactor: MediaQuery.of(context).size.height *
                  //           0.8, // adjust the height based on the screen size
                  //       child: SingleChildScrollView(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Form(
                  //             child: Column(
                  //               children: [
                  //                 TextFormField(
                  //                   decoration: const InputDecoration(
                  //                     labelText: 'Location',
                  //                     border: OutlineInputBorder(),
                  //                   ),
                  //                   validator: (value) {
                  //                     if (value!.isEmpty) {
                  //                       return 'Please enter your location';
                  //                     }
                  //                     return null;
                  //                   },
                  //                 ),
                  //                 TextFormField(
                  //                   decoration: const InputDecoration(
                  //                     labelText: 'Waste Type',
                  //                     border: OutlineInputBorder(),
                  //                   ),
                  //                   validator: (value) {
                  //                     if (value!.isEmpty) {
                  //                       return 'Please enter the waste type';
                  //                     }
                  //                     return null;
                  //                   },
                  //                 ),
                  //                 TextFormField(
                  //                   decoration: const InputDecoration(
                  //                     labelText: 'Quantity',
                  //                     border: OutlineInputBorder(),
                  //                   ),
                  //                   validator: (value) {
                  //                     if (value!.isEmpty) {
                  //                       return 'Please enter the quantity';
                  //                     }
                  //                     return null;
                  //                   },
                  //                 ),
                  //                 const Text('Time of Collection:'),
                  //                 Row(
                  //                   children: [
                  //                     Radio(
                  //                       value:
                  //                           const TimeOfDay(hour: 8, minute: 0),
                  //                       groupValue: timeOfDay,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           timeOfDay = value as TimeOfDay;
                  //                         });
                  //                       },
                  //                     ),
                  //                     const Text('8:00 AM'),
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Radio(
                  //                       value: const TimeOfDay(
                  //                           hour: 12, minute: 0),
                  //                       groupValue: timeOfDay,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           timeOfDay = value as TimeOfDay;
                  //                         });
                  //                       },
                  //                     ),
                  //                     const Text('12:00 PM'),
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Radio(
                  //                       value: const TimeOfDay(
                  //                           hour: 16, minute: 0),
                  //                       groupValue: timeOfDay,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           timeOfDay = value as TimeOfDay;
                  //                         });
                  //                       },
                  //                     ),
                  //                     const Text('4:00 PM'),
                  //                   ],
                  //                 ),
                  //                 ElevatedButton(
                  //                   onPressed: () {
                  //                     // submit the form
                  //                   },
                  //                   child: const Text('Request Waste Pickup'),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestPickup()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('assets/garbage-truck.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Request Pickup',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                       

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestCleanup()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('assets/house-keeping.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Request Cleanup',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
        ],
      ),
    );
  }
}
