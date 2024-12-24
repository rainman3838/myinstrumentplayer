import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class BateriEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrumPadScreen(),
    );
  }
}

class DrumPadScreen extends StatelessWidget {
  final List<String> soundPaths = [
    'sounds/drumses/a.wav',
    'sounds/drumses/b.wav',
    'sounds/drumses/c.wav',
    'sounds/drumses/d.wav',
    'sounds/drumses/e.wav',
    'sounds/drumses/f.wav',
    'sounds/drumses/g.wav',
    'sounds/drumses/h.wav',
    'sounds/drumses/i.wav',
    'sounds/drumses/j.wav',
    'sounds/drumses/k.wav',
    'sounds/drumses/l.wav',
  ];

  final List<List<Color>> gradientColors = [
    [Colors.red, Colors.pink],
    [Colors.pink, Colors.purple],
    [Colors.purple, Colors.deepPurple],
    [Colors.cyan, Colors.lightBlue],
    [Colors.lightBlue, Colors.cyan],
    [Colors.cyan, Colors.teal],
    [Colors.green, Colors.lime],
    [Colors.lime, Colors.yellow.shade600],
    [Colors.yellow, Colors.orange],
    [Colors.orange, Colors.deepOrange],
    [Colors.deepOrange, Colors.redAccent],
    [Colors.redAccent, Colors.red],
  ];

  // Ses dosyasını çalmak için yeni bir AudioPlayer nesnesi oluşturur
  void playSound(String soundPath) {
    final player = AudioPlayer();
    player.play(AssetSource(soundPath));

    // Ses tamamlandığında player'ı serbest bırak
    player.onPlayerComplete.listen((event) {
      player.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Arka plan siyah
      appBar: AppBar(
        backgroundColor: Colors.black, // AppBar rengi
        elevation: 0,
        centerTitle: true,
        title: Stack(
          alignment: Alignment.center,
          children: [
            // AppBar boyunca içteki dairesel kutu
            Container(
              width: 140,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.deepPurple, // Aynı renkte kutu
                borderRadius: BorderRadius.circular(20), // Yuvarlak köşeler
                border: Border.all(
                  color: Colors.white, // Beyaz çerçeve
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Drum Pad',
                style: TextStyle(
                  color: Colors.white, // Yazı rengi
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 85),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 sütun
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: soundPaths.length, // 12 düğme
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  playSound(soundPaths[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: gradientColors[index],
                      center: Alignment.center,
                      radius: 0.6,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
