import 'package:flutter/material.dart';
import 'piyanoekrani.dart';
import 'kanunekrani.dart';
import 'bateriekrani.dart';
import 'kalimbaekrani.dart';

class GirisEkrani extends StatelessWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.white,
        title: const Text('INSTRUMENT PLAYER APP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Başlık mesajı
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Welcome to the Instrument Player App.\nPlease click on the instrument you want to play.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,  // Daha büyük yazı tipi
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Kaydırılabilir liste ile fotoğraflar
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Piyano
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PiyanoEkrani()),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/img1.jpeg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,  // Sabit yükseklik
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Piano',
                            style: TextStyle(
                              fontSize: 18,  // Büyütülen yazı
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Kanun
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => KanunEkrani()),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/img2.jpeg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,  // Sabit yükseklik
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Kanun',
                            style: TextStyle(
                              fontSize: 18,  // Büyütülen yazı
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Drums (Bateri)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BateriEkrani()),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/img3.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,  // Sabit yükseklik
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Kalimba',
                            style: TextStyle(
                              fontSize: 18,  // Büyütülen yazı
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Kalimba
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const KalimbaEkrani()),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/img4.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,  // Sabit yükseklik
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Drums',
                            style: TextStyle(
                              fontSize: 18,  // Büyütülen yazı
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}