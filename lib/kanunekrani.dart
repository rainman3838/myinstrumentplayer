import 'package:flutter/material.dart';

void main() {
  runApp(KanunEkrani());
}

class KanunEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Kanun Ekranı"),
          centerTitle: true,
        ),
        body: Center(
          child: Image.asset(
            'assets/images/imgkanun.jpg', // Resmin yeni yolu
            fit: BoxFit.contain,          // Resmi ekrana sığdırır
          ),
        ),
      ),
    );
  }
}
