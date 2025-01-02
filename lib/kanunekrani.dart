import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class KanunEkrani extends StatefulWidget {
  @override
  State<KanunEkrani> createState() => _KanunEkraniState();
}

class _KanunEkraniState extends State<KanunEkrani> {
  final List<String> soundPaths = [
    'sounds/kanunses/1kanunsol.mp3',
    'sounds/kanunses/2kanunla.mp3',
    'sounds/kanunses/3kanunsi.mp3',
    'sounds/kanunses/4kanundo.mp3',
    'sounds/kanunses/5kanunre.mp3',
    'sounds/kanunses/6kanunmi.mp3',
    'sounds/kanunses/7kanunfa.mp3',
    'sounds/kanunses/8kanunsol.mp3',
    'sounds/kanunses/9kanunla1.mp3',
    'sounds/kanunses/10kanunsi1.mp3',
    'sounds/kanunses/11kanundo1.mp3',
    'sounds/kanunses/1kanunsol.mp3',
    'sounds/kanunses/2kanunla.mp3',
    'sounds/kanunses/3kanunsi.mp3',
  ];




  @override
  Widget build(BuildContext context) {
    // Tellerin dikey pozisyonlarını belirleyin
    List<double> stringPositions = [
      597-(68*8), 597-(68*7), 597-(68*6), 597-(68*5), 597-(68*4), 597-(68*3), 597-(68*2), 597-68, 733-68-68, 733-68, 733, 803, 871, 939
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/kanun.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ...List.generate(stringPositions.length, (index) {
            return Positioned(
              left: 0,
              right: 0,
              top: stringPositions[index],
              child: GestureDetector(
                onTap: () {
                  playSound(soundPaths[index]);
                },
                child: Container(
                  color: Colors.transparent,
                  height: 24,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void playSound(String soundPath) async {
    final player = AudioPlayer();
    await player.play(AssetSource(soundPath));
    player.onPlayerComplete.listen((event) {
      player.dispose();
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: KanunEkrani(),
    debugShowCheckedModeBanner: false,
  ));
}
