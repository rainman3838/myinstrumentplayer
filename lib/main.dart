import 'package:flutter/material.dart';
import 'wlecomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instrument Player App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  WelcomeScreen(),
    );
  }
}