import 'dart:developer';

import 'package:ecowaste/screens/sensoruser/registersensoruser.dart';
import 'package:ecowaste/screens/sensoruser/sensor/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Selectcompany extends StatefulWidget {
  const Selectcompany({super.key});

  @override
  State<Selectcompany> createState() => _SelectcompanyState();
}

class _SelectcompanyState extends State<Selectcompany> {
  final CollectionReference _companiesRef =
      FirebaseFirestore.instance.collection('waste_company');

  String? _selectedCompany;
  final formKey = GlobalKey<FormState>();


  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        backgroundColor: const Color.fromARGB(255, 103, 196, 107),
        title: Text('Select Waste Company'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Sensorregister(),
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
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Text(
                ' Select preferred waste company',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
     
      body: Form(
         key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stepper(
          currentStep: _currentStep,
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          onStepContinue: () {
            if (_currentStep < 1) {
              setState(() {
                _currentStep += 1;
              });
            } else if (_currentStep == 1) {
              // Handle selected company
               if (formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return CupertinoAlertDialog(
                        title: const Text("Info"),
                        content: const Text(
                            "Would you like to proceed with the request?"),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: false,
                            onPressed: () async {
                              _selectCompany();
                              // Navigator.pop(context);
                            },
                            child: const Text("Yes"),
                          )
                        ],
                      );
                    },
                  );
                }
            }
          },
          onStepTapped: (int index) {
            setState(() {
              _currentStep = index;
            });
          },
          steps: [
            Step(
              title: Text('Select Waste Company'),
              content: StreamBuilder<QuerySnapshot>(
                stream: _companiesRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
        
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
        
                  List<DropdownMenuItem<String>> _companies = [];
                  snapshot.data!.docs.forEach((doc) {
                    _companies.add(DropdownMenuItem(
                      value: doc['company_name'],
                      child: Text(doc['company_name']),
                    ));
                  });
        
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          value: _selectedCompany,
                          onChanged: (newVal) {
                            setState(() {
                              _selectedCompany = newVal;
                            });
                          },
                          items: _companies,
                          decoration: InputDecoration(
                            labelText: 'Select Waste Company',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Handle selected company
                          },
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: Text('Confirm Selection'),
              content: Text('You have selected: $_selectedCompany'),
              isActive: _currentStep >= 1,
            ),
          ],
        ),
      ),
    );
  }
    _selectCompany() {
    log('_selectCompany');
    OverlayLoadingProgress.start(
      context,
      barrierDismissible: true,
      widget: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('Sensor_Household')
          .doc(currentUser.uid)
          .collection('sensor pickup_orders')
          .add({
        'Selected company': _selectedCompany,
        'isPickedUp': false,
        'amount': null,
        'requesttimestamp': FieldValue.serverTimestamp(),
        'pickuptimestamp': null,
      }).then((done) {
        log('Completed');
        OverlayLoadingProgress.stop();
        Navigator.pop(context);
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Company Assigned Successfully',
            onConfirmBtnTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) {
                  return const MySensorNavigate();
                },
              ), (Route<dynamic> route) => false);
            });
      }
      );
    }
  }


}
