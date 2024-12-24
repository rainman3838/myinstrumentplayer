import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KalimbaEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ekranı yatay moda sabitle
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Tuş uzunluklarını belirle (ortada en uzun tuş olacak şekilde)
    List<int> keyHeights = [
      130, 145, 160, 175, 190, 205, 220, 235, 250, 235, 220, 205, 190, 175, 160, 145, 130
    ];

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            // Arka plan için ahşap doku
            gradient: LinearGradient(
              colors: [
                Color(0xFF8B4513), // Ahşap açık kahverengi
                Color(0xFFA0522D), // Ahşap koyu kahverengi
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(keyHeights.length, (index) {
              return GestureDetector(
                onTap: () {
                  print("Tuş ${index + 1} çalındı");
                },
                child: Container(
                  width: 40, // Tuş genişliği sabit
                  height: keyHeights[index].toDouble(), // Uzunluk listeden alınıyor
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    // Parlayan gümüş efektli tuşlar
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade300,
                        Colors.grey.shade700,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        offset: Offset(-2, -2),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: KalimbaEkrani(),
    debugShowCheckedModeBanner: false,
  ));
}
