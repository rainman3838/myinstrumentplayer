import 'package:flutter/material.dart';
import 'package:myinstrumentplayer/radio_screen.dart';
import 'package:myinstrumentplayer/girisekrani.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcomescreen.png',
              fit: BoxFit.cover,
            ),
          ),
          // Button to go to Radio Screen
          Positioned(
            left: 55,
            bottom: 350,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GirisEkrani()),
                );
              },
              child: Container(
                width: 340,
                height: 184,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),

                ),

              ),
            ),
          ),
          // Button to go to Instrument Screen
          Positioned(
            right: 58,
            bottom: 100,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RadioScreen()),
                );
              },
              child: Container(
                width: 340,
                height: 184,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),

                ),

              ),
            ),
          ),
        ],
      ),
    );
  }
}

