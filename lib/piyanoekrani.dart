import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PiyanoEkrani(),
    );
  }
}

class PiyanoEkrani extends StatefulWidget {
  const PiyanoEkrani({Key? key}) : super(key: key);

  @override
  State<PiyanoEkrani> createState() => _PiyanoEkraniState();
}

class _PiyanoEkraniState extends State<PiyanoEkrani> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose(){
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        backgroundColor: Colors.white24,
        title: const Text('Piyano Uygulaması'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(7, (index) {
              final isSharp = [0, 1, 3, 4, 5].contains(index);

              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Beyaz tuşa basıldığında yapılacak işlemler
                      print('Beyaz tuş $index basıldı');
                    },
                    child: Container(
                      width: 60,
                      height: 200,
                      color: Colors.white,
                      margin: const EdgeInsets.all(1),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  if (isSharp)
                    Positioned(
                      left: 35,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Siyah tuşa basıldığında yapılacak işlemler
                          print('Siyah tuş $index basıldı');
                        },
                        child: Container(
                          width: 40,
                          height: 120,
                          color: Colors.black,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
