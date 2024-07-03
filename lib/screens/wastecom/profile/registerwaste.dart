import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowaste/screens/household/auth/auth_service.dart';
import 'package:ecowaste/screens/wastecom/navigatewaste.dart';
import 'package:ecowaste/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:ecowaste/screens/wastecom/profile/store_wastecom.dart';
import 'package:ecowaste/screens/wastecom/profile/wastecom_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWasteSignup extends StatefulWidget {
  const MyWasteSignup({
    super.key,
  });

  @override
  State<MyWasteSignup> createState() => _MyWasteSignupState();
}

class _MyWasteSignupState extends State<MyWasteSignup> {
  final _auth = AuthService();
  final _wasteController = TextEditingController();
  final _passwordController = TextEditingController();
  final _contactController = TextEditingController();
  final _mailController = TextEditingController();
  final _locationController = TextEditingController();
  bool passwordVisible = false;
  String? availableDays;

  final wasteRepo = Get.put(WasteRepository());

  final formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      setState(() {
        autoValidateMode = AutovalidateMode.disabled;
      });

      return true;
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.onUserInteraction;
      });
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    _wasteController.dispose();
    _passwordController.dispose();
    _contactController.dispose();
    _mailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        backgroundColor: const Color.fromARGB(255, 103, 196, 107),
        title: const Text('Account Details'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyAccount(),
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
                  Text(
                    'Create Account',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Text(
                ' Fill in your details to join',
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
          // currentStep: _currentStep,
          // onStepContinue: () {
          //   log("Continue pressed");
          //   _currentStep < 3 ? _nextStep : _signup;
          // },
          // onStepCancel: _currentStep > 0 ? _previousStep : null,
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
                          "Would you like to proceed with the registration?"),
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
                            _signup();
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
              title: Text('Company Name'),
              content: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _wasteController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name',
                    prefixIcon: Icon(Icons.business),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a valid company name';
                    }
                    return null;
                  },
                ),
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: Text('Email and Phone'),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _mailController,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _contactController,
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
              title: Text('Location and Available Days'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          return 'Please enter the company location';
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
                        Text('Select Available Days'),
                        SizedBox(height: 10),
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
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          style: TextStyle(
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
                ],
              ),
              isActive: _currentStep >= 2,
            ),
            Step(
              title: Text('Password'),
              content: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      )),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a valid password';
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

  void _nextStep() {
    log("_nextStep");
    if (formKey.currentState!.validate()) {
      log("Workinngggg");
      setState(() {
        _currentStep++;
      });
    } else {
      log("Issue dey");
    }
  }

  void _previousStep() {
    setState(() {
      _currentStep--;
    });
  }

  _signup() async {
    // Initialized Shared Preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
    final user = await _auth.createUserWithEmailAndPassword(
        _mailController.text.trim(), _passwordController.text);
    if (user != null) {
      User? currentUser = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('waste_company')
          .doc(currentUser!.uid)
          .set({
        'company_name': _wasteController.text,
        'email': _mailController.text.trim(),
        'contact': _contactController.text,
        'location': _locationController.text,
        'available_days': availableDays,
        'role': 'Waste Company'
      });

      // Save user details in Shared preferences
      await prefs.setString(
        'company_name',
        _wasteController.text,
      );
      await prefs.setString(
        'company_email',
        _mailController.text,
      );
      await prefs.setString(
        'company_contact',
        _contactController.text,
      );

      OverlayLoadingProgress.stop();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return MyWasteNavigate();
        },
      ), (Route<dynamic> route) => false);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const MyWasteNavigate()),
      // );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Invalid credentials',
      );
      OverlayLoadingProgress.stop();
    }
  }

  Future<void> createUser(WasteModel wuser) async {
    await wasteRepo.createUser(wuser);
  }
}
