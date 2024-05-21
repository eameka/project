import 'package:flutter/material.dart';

class MywasteLogin extends StatefulWidget {
  const MywasteLogin({
    super.key,
  });

  @override
  State<MywasteLogin> createState() => _MywasteLoginState();
}

class _MywasteLoginState extends State<MywasteLogin> {
   

   bool passwordVisible = false;
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

 @override 
    void initState(){ 
      super.initState(); 
      passwordVisible=true; 
    }  

     @override
    void dispose(){
      super.dispose();
    _mailController.dispose();
    _passwordController.dispose();   
    } 

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
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
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _mailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail),
                labelText: 'Waste Company e-mail',
                border: OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(25),),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                  ),),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
             onPressed: (){},
            child: const Text('Login'),),
        ],
      ),
    );
  }
}