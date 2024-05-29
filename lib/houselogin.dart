
import 'package:flutter/material.dart';
import 'educate.dart';

class MyHouseLogin extends StatefulWidget {
  const MyHouseLogin({
    super.key,
  });

  @override
  State<MyHouseLogin> createState() => _MyHouseLoginState();
}

class _MyHouseLoginState extends State<MyHouseLogin> {
  

  bool passwordVisible = false;
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    _contactController.dispose();
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
        backgroundColor: Colors.green,
         leading:  IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Heya! Welcome Back',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
            padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 35.0, right: 35.0),
            child: TextFormField(
              controller: _contactController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'Contact',
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(25),
                   ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left: 35.0, right: 35.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                  border: const OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(25),),
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
            ),
          ),
          const SizedBox(height: 10),
         const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Text('Forgot password?'),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(child: const Text('Login'), onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const Educate(),)),),
        ],
      ),
    );
  }
}