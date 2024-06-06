import 'package:ecowaste/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
    await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey:  "AIzaSyCAsrVpw981ZYnfZSBRTbm7euY6wmLcBSs", 
      appId: "1:523222427904:web:1620fbd0a7740254082be5", 
      messagingSenderId:  "523222427904", 
      projectId:  "wasteapp-1fb69")
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Eco-Planet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor:const Color.fromARGB(255, 202, 255, 204),
        ),
        useMaterial3: true,
      ),
      home: const Mysplash(),
    );
  }
}
