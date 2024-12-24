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

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Arka plan siyah
      appBar: AppBar(
        title: Text('Drum Pad'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
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
                audioPlayer.play(AssetSource(soundPaths[index]));
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
    );
  }
}
