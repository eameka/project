import 'package:custom_signin_buttons/custom_signin_buttons.dart';
import 'package:ecowaste/auth_service.dart';
import 'package:ecowaste/navigatewaste.dart';
import 'package:ecowaste/store_user.dart';
import 'package:ecowaste/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
  bool passwordVisible = false;
  
   final wasteRepo = Get.put(WasteRepository());

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
        backgroundColor: const Color.fromARGB(255, 202, 255, 204),
        title: const Text('Account Details'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(200),
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
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 35.0, right: 35.0),
            child: TextFormField(
              controller: _wasteController,
              decoration: const InputDecoration(
                labelText: 'Waste Company Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter valid Username';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 35.0, right: 35.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
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
          const SizedBox(height: 10),
          Padding(
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
                  return 'Please enter valid Contact';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 35.0, right: 35.0),
            child: TextFormField(
              controller: _mailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.phone),
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
          const SizedBox(height: 10),
          GestureDetector(
              onTap: () {
                // Your action here
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    height:  MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      children: [
                        const Text(
                          "Terms and Conditions",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height:5,
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
                          height:5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                               style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 103, 196, 107),
                              )),
                              onPressed: () {
                                // Decline action
                                Navigator.pop(context);
                              },
                              child: const Text("Decline", style: TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                               style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 103, 196, 107),
                              )),
                              onPressed: () {
                                // Accept action
                                Navigator.pop(context);
                                // Add your logic here to handle the acceptance of terms and conditions
                              },
                              child: const Text("Accept", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text(
                "I accept the terms and conditions",
                style: TextStyle(color: Color.fromARGB(255, 137, 253, 156)),
              ),
            ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed:(){
               final wuser =WasteModel(
                  name: _wasteController.text,
                  password: _passwordController.text,
                  email: _mailController.text ,
                  contact: _contactController.text,
                );
                WasteRepository.instance.createUser(wuser);
              _signup();
            } ,
            child: const Text('Sign up'),
          ),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.fromLTRB(3, 0, 0, 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 6),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF070707),
                    ),
                    width: 111,
                    height: 1,
                  ),
                ),
                const Text(
                  'Or Register with',
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 6),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF070707),
                    ),
                    width: 111,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SignInButton(
            button: Button.Google,
            small: true,
          ),
        ],
      ),
    );
  }

  _signup() async {
    final user = await _auth.createUserWithEmailAndPassword(
        _mailController.text, _passwordController.text);
    if (user != null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'User SignUp Completed Successfully!',
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyWasteNavigate()),
      );
    }
  }

   Future<void> createUser(WasteModel wuser) async {
    await wasteRepo.createUser(wuser);
  }
}

