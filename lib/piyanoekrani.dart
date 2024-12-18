import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Piyano Uygulaması'),
        ),
        body: const PiyanoEkrani(),
      ),
    );
  }
}

class PiyanoEkrani extends StatelessWidget {
  const PiyanoEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(12, (index) {
          final isSharp = [1, 2, 4, 5, 6].contains(index % 7);


          return Stack(
            children: [
              Container(
                width: 60,
                height: 200,
                color: Colors.white,
                margin: const EdgeInsets.all(1),
                alignment: Alignment.bottomCenter,

              ),
              if (isSharp)
                Positioned(
                  left: 35,
                  top: 0,
                  child: Container(
                    width: 40,
                    height: 120,
                    color: Colors.black,
                    alignment: Alignment.bottomCenter,

                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}