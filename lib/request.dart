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
final _formKey = GlobalKey<FormState>();

   String _mobileNumber = " ";
   String _name = " ";
    String _mail = " ";
    String? _timeOfDay;

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
        _mobileNumber = snapshot.get('Contact').toString();
      });
    }
  }

   _retrieveName() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _name = snapshot.get('Household name').toString();
      });
    }
  }

 _retrieveMail() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _mail = snapshot.get('Email').toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
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
              color: const Color.fromARGB(255, 103, 196, 107),
            ),
            child: Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(137, 46, 45, 45)
                ),
              ),
            ),
           ),
           SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap:(){},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration:  BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                              image: AssetImage('assets/pickup.jpeg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                       const Center(
                         child: Padding(
                           padding: EdgeInsets.all(8.0),
                           child: Text('Request Pickup', style:TextStyle(color:Colors.white)),
                         ),
                       ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap:(){
                   showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) =>

               FractionallySizedBox(
                heightFactor: MediaQuery.of(context).size.height * 0.8,
                 child: SingleChildScrollView(
                  child: Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Location',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your location';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Time of Collection',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a time of collection';
                                }
                                return null;
                              },
                            ),
                          ),
                          RadioListTile(
                            title: const Text('Morning'),
                            value: 'Morning',
                            groupValue: _timeOfDay,
                            onChanged: (value) {
                              setState(() {
                                _timeOfDay = value as String;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text('Afternoon'),
                            value: 'Afternoon',
                            groupValue: _timeOfDay,
                            onChanged: (value) {
                              setState(() {
                                _timeOfDay = value as String;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text('Evening'),
                            value: 'Evening',
                            groupValue: _timeOfDay,
                            onChanged: (value) {
                              setState(() {
                                _timeOfDay = value as String;
                              });
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Submit the form here
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                               ),
               ),
            );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration:  BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                              image: AssetImage('assets/cleanup.jpeg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                       const Center(
                         child: Padding(
                           padding: EdgeInsets.all(8.0),
                           child: Text('Request Cleanup', style:TextStyle(color:Colors.white)),
                         ),
                       ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
              GestureDetector(
                onTap:(){
                  showModalBottomSheet(
  context: context,
  isScrollControlled: true, // make the sheet scrollable
  builder: (context) {
     TimeOfDay timeOfDay = const TimeOfDay(hour: 8, minute: 0);
    return FractionallySizedBox(
      heightFactor: MediaQuery.of(context).size.height * 0.8, // adjust the height based on the screen size
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Waste Type',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the waste type';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the quantity';
                    }
                    return null;
                  },
                ),
                const Text('Time of Collection:'),
                Row(
                  children: [
                    Radio(
                      value: const TimeOfDay(hour: 8, minute: 0),
                      groupValue: timeOfDay,
                      onChanged: (value) {
                        setState(() {
                          timeOfDay = value as TimeOfDay;
                        });
                      },
                    ),
                    const Text('8:00 AM'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: const TimeOfDay(hour: 12, minute: 0),
                      groupValue: timeOfDay,
                      onChanged: (value) {
                        setState(() {
                          timeOfDay = value as TimeOfDay;
                        });
                      },
                    ),
                    const Text('12:00 PM'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: const TimeOfDay(hour: 16, minute: 0),
                      groupValue: timeOfDay,
                      onChanged: (value) {
                        setState(() {
                          timeOfDay = value as TimeOfDay;
                        });
                      },
                    ),
                    const Text('4:00 PM'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // submit the form
                  },
                  child: const Text('Request Waste Pickup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration:  BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle,
                            image: const DecorationImage(
                              image: AssetImage('assets/orders.jpeg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                       const Center(
                         child: Padding(
                           padding: EdgeInsets.all(8.0),
                           child: Text('Orders', style:TextStyle(color:Colors.white)),
                         ),
                       ),
                    ],
                  ),
                ),
              ),
             ],
          ),
          ],
          ),
    );
  }
}
