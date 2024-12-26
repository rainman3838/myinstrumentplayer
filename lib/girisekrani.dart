import 'package:flutter/material.dart';
import 'bateriekrani.dart';
import 'kalimbaekrani.dart';
import 'kanunekrani.dart';
import 'piyanoekrani.dart';

class GirisEkrani extends StatelessWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Enstruman.png',
              fit: BoxFit.cover,
            ),
          ),
          // Instrument buttons
          Positioned(
            top: 260,
            left: 70,
            child: InstrumentButton(
              label: 'Piano',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KalimbaEkrani()),
                );
              },
            ),
          ),
          Positioned(
            top: 260,
            right: 50,
            child: InstrumentButton(
              label: 'Piyano',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PiyanoEkrani()),
                );
              },
            ),
          ),
          Positioned(
            bottom: 400,
            left: 50,
            child: InstrumentButton(
              label: 'Drums',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BateriEkrani()),
                );
              },
            ),
          ),
          Positioned(
            bottom: 400,
            right: 70,
            child: InstrumentButton(
              label: 'Kanun',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KanunEkrani()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InstrumentButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const InstrumentButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(70),

        ),

      ),
    );
  }
}
