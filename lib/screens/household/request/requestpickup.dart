import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowaste/screens/household/request/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:geolocator/geolocator.dart';

class RequestPickup extends StatefulWidget {
  const RequestPickup({super.key});

  @override
  State<RequestPickup> createState() => _RequestPickupState();
}

class _RequestPickupState extends State<RequestPickup> {
 final _address = TextEditingController();
   final  _name = TextEditingController();
   final _contact = TextEditingController();
   final  _quantityController = TextEditingController();
   final  _specialController = TextEditingController();



  final formKey = GlobalKey<FormState>();
 
  int _currentStep = 0;
  String?  waste;
  String?  availableDays;
  String?  availableTime;
   


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
                  builder: (context) => const Notify(),
                ));
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        bottom:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
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
                            Navigator.pop(context);
                            _pickuprequest();
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
                   readOnly: true,
                      onTap: () async {
                        Position? position = await updateLocation();
                        if (position != null) {
                          _address.text =
                              '${position.latitude}, ${position.longitude}';
                          setState(() {});
                        }
                      },
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
              title: const Text('Name and Phone'),
              content: Column(
                children: [
                  Padding(
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
                          return 'Please enter your name';
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
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a special request';
                        }
                        return null;
                      },
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
               
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: TextFormField(
                  //     controller: _passwordController,
                  //     obscureText: !passwordVisible,
                  //     decoration: InputDecoration(
                  //         labelText: 'Password',
                  //         prefixIcon: const Icon(Icons.lock),
                  //         border: const OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(25),
                  //           ),
                  //         ),
                  //         suffixIcon: IconButton(
                  //           onPressed: () {
                  //             setState(() {
                  //               passwordVisible = !passwordVisible;
                  //             });
                  //           },
                  //           icon: Icon(
                  //             passwordVisible
                  //                 ? Icons.visibility
                  //                 : Icons.visibility_off,
                  //           ),
                  //         )),
                  //     validator: (value) {
                  //       if (value?.isEmpty ?? true) {
                  //         return 'Please enter a valid password';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
               
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
     FirebaseFirestore.instance.collection('pickup_orders').doc(currentUser!.uid).set({
        'contact': _contact.text,
        'name': _name.text,
        'location': _address.text,
        'Additional Info': _specialController.text,
        'Quantity': _quantityController.text,
        'Available Days': availableDays,
        'Available Times': availableTime,
        'Waste type': waste,

      });
      OverlayLoadingProgress.stop();
      Navigator.pop(context);
  }

   Future updateLocation() async {
    Position? newPosition;

    LocationPermission res = await Geolocator.requestPermission();

    if (res.name == 'always' || res.name == 'whileInUse') {
      try {
        OverlayLoadingProgress.start(
          context,
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

        newPosition = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best)
            .timeout(const Duration(seconds: 30));

        OverlayLoadingProgress.stop();
      } catch (e) {
        OverlayLoadingProgress.stop();
        print('GPS Error: ${e.toString()}');

        // errorSnackBar('Kindly check your internet connection');
      }
    }

    return newPosition;
  }
}