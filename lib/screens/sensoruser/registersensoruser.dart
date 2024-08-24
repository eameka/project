import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecowaste/register.dart';
import 'package:ecowaste/screens/household/auth/auth_service.dart';
import 'package:ecowaste/screens/sensoruser/selectcompany.dart';
import 'package:ecowaste/screens/sensoruser/sensorscreen.dart';
import 'package:ecowaste/screens/sensoruser/store_sensor_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sensorregister extends StatefulWidget {
  const Sensorregister({super.key});

  @override
  State<Sensorregister> createState() => _SensorregisterState();
}

class _SensorregisterState extends State<Sensorregister> {
  final _auth = AuthService();
  final _householdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();
  final _contactController = TextEditingController();

  final userRepo = Get.put(SensorRepository());
  bool passwordVisible = false;
  final formKey = GlobalKey<FormState>();

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
    _householdController.dispose();
    _passwordController.dispose();
    _mailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
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
          preferredSize: Size.fromHeight(150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create Sensor Household Account',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 35.0, right: 35.0),
                    child: TextFormField(
                      controller: _householdController,
                      decoration: const InputDecoration(
                        labelText: 'Sensor Household Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter valid Household name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 35.0, right: 35.0),
                    child: TextFormField(
                      controller: _mailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter valid E-mail';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 35.0, right: 35.0),
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
                          return 'Please enter valid mobile number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 35.0, right: 35.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: passwordVisible,
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
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter valid password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    // Your action here
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  const Text(
                                    "Terms and Conditions",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "1. By using this app, you agree to comply with all applicable laws and regulations regarding waste management.",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    '2. The information provided in the app is for general informational purposes only and should not be considered professional advice.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    '3. We are not responsible for any damages or losses incurred as a result of using the app or relying on the information provided.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    '4. The app may contain links to third-party websites or services. We have no control over the content and availability of these sites and services.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    '5. Your use of the app may be subject to additional terms and conditions specific to certain features or services.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    '6. We reserve the right to modify or terminate the app at any time without prior notice.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    '7. Any personal information you provide through the app will be handled in accordance with our privacy policy.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    '8. You are solely responsible for the accuracy and legality of any content you submit through the app.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    "9. We may collect anonymous usage data to improve the app's functionality and user experience.",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Text(
                                    '10. By using the app, you agree to indemnify and hold us harmless from any claims, damages, or liabilities arising out of your use of the app.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 103, 196, 107),
                                        )),
                                        onPressed: () {
                                          // Decline action
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Decline",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 103, 196, 107),
                                        )),
                                        onPressed: () {
                                          // Accept action
                                          Navigator.pop(context);
                                          // Add your logic here to handle the acceptance of terms and conditions
                                        },
                                        child: const Text("Accept",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    "I accept the terms and conditions",
                    style: TextStyle(color: Color(0Xff0C2925)),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (validateAndSave()) {
                      _signup();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color(0Xff0C2925),
                    ),
                  ),
                  child: const Text('Sign up',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signup() async {
    // Initialized Shared Preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Initialized Loader
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
    // Initialized the user creation process
    final user = await _auth.createUserWithEmailAndPassword(
        _mailController.text, _passwordController.text);

    if (user != null) {
      // Get current user if user creation was successful
      User? currentUser = FirebaseAuth.instance.currentUser;

      // Save the user details into the database
      FirebaseFirestore.instance
          .collection('Sensor_Household')
          .doc(currentUser!.uid)
          .set({
        'contact': _contactController.text,
        'email': _mailController.text,
        'name': _householdController.text,
        'role': 'Sensor Household'
      });

      // Save user details in Shared preferences
      await prefs.setString(
        'sensor_name',
        _householdController.text,
      );
      await prefs.setString(
        'sensor_email',
        _mailController.text,
      );
      await prefs.setString(
        'sensor_contact',
        _contactController.text,
      );
      OverlayLoadingProgress.stop();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return Selectcompany();
        },
      ), (Route<dynamic> route) => false);
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Invalid credentials',
      );
      OverlayLoadingProgress.stop();
    }
  }
}
