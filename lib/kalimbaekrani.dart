import 'package:flutter/material.dart';

class KalimbaEkrani extends StatelessWidget {
  const KalimbaEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalimba Ekranı'),
      ),
      body: const Center(
        child: Text('Bu ekran Kalimba arayüzü için.'),
      ),
    );
  }
}