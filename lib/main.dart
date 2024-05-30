import 'package:ecowaste/splash.dart';
import 'package:flutter/material.dart';

void main() {
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
