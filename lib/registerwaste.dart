import 'package:custom_signin_buttons/custom_signin_buttons.dart';
import 'package:flutter/material.dart';

class MyWasteSignup extends StatefulWidget {
  const MyWasteSignup({
    super.key,
  });

  @override
  State<MyWasteSignup> createState() => _MyWasteSignupState();
}

class _MyWasteSignupState extends State<MyWasteSignup> {
  final _wasteController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();
  bool passwordVisible = false;
  bool _isChecked = false;

@override 
    void initState(){ 
      super.initState(); 
      passwordVisible=true; 
    }   

     @override
    void dispose(){
      super.dispose();
    _wasteController.dispose();
    _passwordController.dispose(); 
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
        leading:  IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25),),
        ),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(200), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Text('Create Account', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
                  SizedBox(height: 20,),
                ],
            ),
               Text(' Fill in your details to join', style: TextStyle(fontSize: 15, color: Colors.black),),
                SizedBox(height: 30,)
          ],
        ), ),
      ),
      body: Column(
        children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _wasteController,
                  decoration: const InputDecoration(
                    labelText: 'Waste Company Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(25),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration:  InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(25),
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
                        )
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _mailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(25),
                      ),),
                  ),
                ),
              ),
              const SizedBox(height: 10),
               CheckboxListTile(
                  title: const Text('I agree to the terms and conditions'),
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = true;
                    });
                  },
                ),
                 const SizedBox(height: 15),
              ElevatedButton(
                onPressed: (){},
                child: const Text('Sign up'),
                
              ),
               const SizedBox(height: 30),
             const Divider(
                        color: Colors.black,
                        thickness: 3,
                        height: 3.0,
                        indent: 20,
                        endIndent: 20,
                 ),
                  const SizedBox(height: 25),
                 SignInButton(
                  button: Button.Google,
                  small: true,
                 ),
        ],
      ),
    );
  }
}