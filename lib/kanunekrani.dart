import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class KanunEkrani extends StatefulWidget {
  @override
  _KanunEkraniState createState() => _KanunEkraniState();
}

class _KanunEkraniState extends State<KanunEkrani> {
  final AudioPlayer _player = AudioPlayer();
  final List<String> sesDosyalari = [
    'assets/sounds/kanunses/1kanunsol.mp3',
    'assets/sounds/kanunses/2kanunla.mp3',
    // ... diğer ses dosyaları
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/kanun.png'),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Her satırda 3 tel
                ),
                itemCount: sesDosyalari.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      _player.play(AssetSource(sesDosyalari[index]));
                    },
                    child: Text(''),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}