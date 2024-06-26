import 'package:ecowaste/screens/household/auth/auth_service.dart';
import 'package:ecowaste/forgotpassword.dart';
import 'package:ecowaste/screens/wastecom/navigatewaste.dart';
import 'package:ecowaste/register.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class MywasteLogin extends StatefulWidget {
  const MywasteLogin({
    super.key,
  });

  @override
  State<MywasteLogin> createState() => _MywasteLoginState();
}

class _MywasteLoginState extends State<MywasteLogin> {
  final _auth = AuthService();
  bool passwordVisible = false;
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 103, 196, 107),
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
                    'Login',
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
                ' Fill in your details to login',
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Heya! Welcome Back',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          const Text(
            'Healthy Environment means Good Health',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your health your environment',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 35.0, right: 35.0),
            child: TextFormField(
              controller: _mailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail),
                labelText: 'E-mail',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 35.0, right: 35.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                labelText: 'Password',
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
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter valid password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 5),
           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      )),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Forgot password?'),
                  )),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: _login,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  _login() async {
    final user = await _auth.loginUserWithEmailAndPassword(
        _mailController.text, _passwordController.text);
    if (user != null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'User Login Completed Successfully!',
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MyWasteNavigate()));
    }
  }
}
