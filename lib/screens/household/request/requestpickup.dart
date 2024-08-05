import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowaste/screens/household/navigate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
//import 'package:location/location.dart';

class RequestPickup extends StatefulWidget {
  const RequestPickup({super.key});

  @override
  State<RequestPickup> createState() => _RequestPickupState();
}

class _RequestPickupState extends State<RequestPickup> {
  String? selectedcompany;
  final _address = TextEditingController();
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _quantityController = TextEditingController();
  final _specialController = TextEditingController();
  // Location _location = Location();

  CollectionReference companies =
      FirebaseFirestore.instance.collection('waste_company');

  final formKey = GlobalKey<FormState>();

  int _currentStep = 0;
  String? waste;
  String? availableDays;
  String? availableTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        backgroundColor: const Color.fromARGB(255, 103, 196, 107),
        title: const Text('Request Waste Pickup'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigateHouseHold(),
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
                ' Fill in details to request pickup',
                style: TextStyle(fontSize: 15, color: Colors.black),
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
            if (_currentStep < 2) {
              setState(() {
                _currentStep += 1;
              });
            } else if (_currentStep == 2) {
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
                            _pickuprequest();
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
              title: const Text('Basic Information'),
              content: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _address,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.home),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a valid address';
                    }
                    return null;
                  },
                ),
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text('Waste Details'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        hintText: 'number of bags, weight',
                        prefixIcon: Icon(Icons.delete),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the quantity of waste';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Select type of waste'),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          items: <String>[
                            'Household trash',
                            'Recyclables',
                            'Yard/Garden waste',
                            'Construction debris',
                          ].map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          value: waste,
                          onChanged: (newVal) {
                            setState(() {
                              waste = newVal;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'This is required *';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _specialController,
                      decoration: const InputDecoration(
                        labelText: 'Special Requests',
                        hintText: 'bulk items, hazardous materials',
                        prefixIcon: Icon(Icons.delete),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                     
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
            ),
            Step(
              title: const Text('Pickup Preferences'),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Select Pickup Company'),
                        const SizedBox(height: 10),
                        StreamBuilder<QuerySnapshot>(
                          stream: companies.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    "Some error occurred ${snapshot.error}"),
                              );
                            }

                            List<DropdownMenuItem<String>>? companyitems = [];
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            } else {
                              final selectcompanies =
                                  snapshot.data?.docs.reversed.toList();
                              if (selectcompanies != null) {
                                for (var company in selectcompanies) {
                                  companyitems.add(DropdownMenuItem(
                                    value: company['email'],
                                    child: Text(company['company_name']),
                                  ));
                                }
                              }
                            }

                            // Ensure selectedcompany is set to a valid value
                            if (companyitems.isNotEmpty &&
                                (selectedcompany == null ||
                                    !companyitems.any((item) =>
                                        item.value == selectedcompany))) {
                              selectedcompany = companyitems.first.value;
                            }

                            return DropdownButtonFormField<String>(
                              items: companyitems,
                              onChanged: (newVal) {
                                setState(() {
                                  selectedcompany = newVal;
                                });
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              value: selectedcompany,
                              validator: (value) {
                                if (value == null) {
                                  return 'This is required *';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Select Available Days'),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          items: <String>[
                            'Monday',
                            'Tuesday',
                            'Wednesday',
                            'Thursday',
                            'Friday',
                            'Saturday',
                            'Sunday',
                            'Everyday',
                            'Weekdays',
                            'Weekends'
                          ].map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          value: availableDays,
                          onChanged: (newVal) {
                            setState(() {
                              availableDays = newVal;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'This is required *';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Select Available Times'),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          items: <String>[
                            'Morning',
                            'Afternoon',
                            'Evening',
                          ].map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          value: availableTime,
                          onChanged: (newVal) {
                            setState(() {
                              availableTime = newVal;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'This is required *';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 3,
            ),
          ],
        ),
      ),
    );
  }

  _pickuprequest() {
    log('_pickuprequest');
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
          .collection('users')
          .doc(currentUser.uid)
          .collection('pickup_orders')
          .add({
        'location': _address.text,
        'Additional Info': _specialController.text,
        'Quantity': _quantityController.text,
        'Available Days': availableDays,
        'Available Times': availableTime,
        'Waste type': waste,
        'Selected company': selectedcompany,
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
            text: 'Request submitted successfully',
            onConfirmBtnTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) {
                  return const NavigateHouseHold();
                },
              ), (Route<dynamic> route) => false);
            });
      }
      );
    }
  }
}
