import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowaste/screens/household/navigate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
//import 'package:location/location.dart';

class RequestCleanup extends StatefulWidget {
  const RequestCleanup({super.key});

  @override
  State<RequestCleanup> createState() => _RequestCleanupState();
}

class _RequestCleanupState extends State<RequestCleanup> {
  String? selectedcompany;
  final _locationController = TextEditingController();
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _wastetype = TextEditingController();
  final _extraInfo = TextEditingController();
 // Location _location = Location();

  CollectionReference companies =
      FirebaseFirestore.instance.collection('waste_company');

  final formKey = GlobalKey<FormState>();
  String? availableDays;
  String? availableCompanies;

  int _currentStep = 0;

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _contact.dispose();
    _wastetype.dispose();
    _extraInfo.dispose();
  }

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
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
          child: const Column(
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
                ' Fill in details to request cleanup',
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
            if (_currentStep < 3) {
              setState(() {
                _currentStep += 1;
              });
            } else if (_currentStep == 3) {
              if (formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return CupertinoAlertDialog(
                      title: const Text("Info"),
                      content: const Text(
                          "Would you like to proceed with the cleanup request?"),
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
                            Navigator.pop(context);
                            _cleanuprequest();
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
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                ),
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text('Location'),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _contact,
                      decoration: const InputDecoration(
                        labelText: 'Contact',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a valid contact';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: const Text('Cleanup Details'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _wastetype,
                      decoration: const InputDecoration(
                        labelText: 'Type of waste',
                        hintText: 'trash/recyclables',
                        prefixIcon: Icon(Icons.delete),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter type of waste';
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
                        const Text('Select Available Companies'),
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
                            List<DropdownMenuItem> companyitems = [];
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            } else {
                              final selectcompanies =
                                  snapshot.data?.docs.reversed.toList();
                              if (selectcompanies != null) {
                                for (var company in selectcompanies) {
                                  companyitems.add(DropdownMenuItem(
                                    value: company.id,
                                      child: Text(
                                    company['company_name'],
                                  )));
                                }
                              }
                            }
                            
                            return Padding(
                              padding: const EdgeInsets.only(
                                right:15.0,
                                left:15.0,
                                ),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                hint: const Text("Select available companies"),
                                value: selectedcompany,
                                items: companyitems,
                                onChanged: (newVal) {
                                  setState(() {
                                    selectedcompany = newVal;
                                  });
                                },
                              ),
                            );
                          },
                        )
                      
                      ],
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
            ),
            Step(
              title: const Text('Additional Information'),
              content: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _extraInfo,
                  decoration: const InputDecoration(
                    labelText: 'Info',
                    hintText: 'Enter any additional information',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter any additional info';
                    }
                    return null;
                  },
                ),
              ),
              isActive: _currentStep >= 3,
            ),
          ],
        ),
      ),
    );
  }

  _cleanuprequest() {
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
    if (currentUser != null){
    FirebaseFirestore.instance   
        .collection('users')
        .doc(currentUser.uid)
        .collection('cleanup_orders')
        .add({
      'Name': _name.text,
     'Contact': _contact.text,
      'location': _locationController.text,
      'Additional info': _extraInfo.text,
      'Waste type': _wastetype.text,
      'Available Days': availableDays,
      'Selected company': selectedcompany,
    });
    OverlayLoadingProgress.stop();
    Navigator.pop(context);
  }
}
}