import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bateriekrani.dart';
import 'kalimbaekrani.dart';
import 'kanunekrani.dart';
import 'piyanoekrani.dart';

class GirisEkrani extends StatelessWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        title: const Text('Instrument Player'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Welcome to the Instrument Player App. Select an instrument to start playing.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  InstrumentTile(
                    imagePath: 'assets/images/img1.jpeg',
                    instrumentName: 'Piano',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PiyanoEkrani()),
                      );
                    },
                  ),
                  InstrumentTile(
                    imagePath: 'assets/images/img2.jpeg',
                    instrumentName: 'Kanun',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KanunEkrani()),
                      );
                    },
                  ),
                  InstrumentTile(
                    imagePath: 'assets/images/img4.jpg',
                    instrumentName: 'Drums',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  BateriEkrani()),
                      );
                    },
                  ),
                  InstrumentTile(
                    imagePath: 'assets/images/img3.jpg',
                    instrumentName: 'Kalimba',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  KalimbaEkrani()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InstrumentTile extends StatelessWidget {
  final String imagePath;
  final String instrumentName;
  final VoidCallback onTap;

  const InstrumentTile({
    Key? key,
    required this.imagePath,
    required this.instrumentName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15.0)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                instrumentName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
