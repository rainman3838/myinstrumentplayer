import 'package:flutter/material.dart';

class BateriEkrani extends StatelessWidget {
  const BateriEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bateri Ekranı'),
      ),
      body: const Center(
        child: Text('Bu ekran Bateri arayüzü için.'),
      ),
    );
  }
}