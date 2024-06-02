import 'package:ecowaste/settings.dart';
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
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
                    'Select your type of waste',
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
                'Choose the type(s) of waste you may dispose',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
      body:  Center(
        child: Container(
          width: 350,
          height:450,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Color.fromARGB(255, 206, 250, 200),
          ),
          child: Column(
            children: [
             const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                          width: 300,
                          height:80,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(image: AssetImage('assets/plastic.jpg')),
                                ),
                              ),
                              const SizedBox(width:5),
                              const Expanded(child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text('Plastic', style:TextStyle(fontSize: 20,fontStyle: FontStyle.italic,)),
                              ), ),
                              const SizedBox(width:1),
                             Expanded(child: Padding(
                               padding: const EdgeInsets.all(3.0),
                               child: ElevatedButton(onPressed: () {}, child: const Text('Select')),
                             ),),
                            ],
                          ),
                          ),
              ),
               Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                          width: 300,
                          height:80,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(image: AssetImage('assets/glass.jpeg')),
                                ),
                              ),
                              const SizedBox(width:5),
                              const Expanded(child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text('Glass', style:TextStyle(fontSize: 20, fontStyle: FontStyle.italic,)),
                              ), ),
                              const SizedBox(width:1),
                             Expanded(child: Padding(
                               padding: const EdgeInsets.all(3.0),
                               child: ElevatedButton(onPressed: () {}, child: const Text('Select')),
                             ),),
                            ],
                          ),
                          ),
              ),
               Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                          width: 300,
                          height:80,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(image: AssetImage('assets/metal.jpg')),
                                ),
                              ),
                              const SizedBox(width:5),
                              const Expanded(child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text('Metal', style:TextStyle(fontSize: 20,fontStyle: FontStyle.italic,)),
                              ), ),
                              const SizedBox(width:1),
                             Expanded(child: Padding(
                               padding: const EdgeInsets.all(3.0),
                               child: ElevatedButton(onPressed: () {}, child: const Text('Select')),
                             ),),
                            ],
                          ),
                          ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => const Settings(),)), child: const Text('Continue')),
              ),
            ],
          ),
        ),
      ),
        
    );
  }
}
