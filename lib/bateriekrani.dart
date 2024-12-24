import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
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
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/2kalimbare.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/1kalimbado.mp3',
  ];
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.cyan,
    Colors.pink,
    Colors.indigo,
    Colors.lime,
    Colors.teal,
    Colors.amber,
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drum Pad'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 sütun
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: soundPaths.length, // 12 buton
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () async {
                try {
                  await audioPlayer.play(AssetSource(soundPaths[index]));
                } catch (e) {
                  print("Error playing sound: $e");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors[index],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Pad ${index + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
