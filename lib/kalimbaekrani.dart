import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class KalimbaEkrani extends StatefulWidget {
  @override
  State<KalimbaEkrani> createState() => _KalimbaEkraniState();
}

class _KalimbaEkraniState extends State<KalimbaEkrani> {
  final List<String> soundPaths = [
    'sounds/kalimbases/1kalimbado.mp3',
    'sounds/kalimbases/2kalimbare.mp3',
    'sounds/kalimbases/3kalimbami.mp3',
    'sounds/kalimbases/4kalimbafa.mp3',
    'sounds/kalimbases/5kalimbasol.mp3',
    'sounds/kalimbases/6kalimbala.mp3',
    'sounds/kalimbases/7kalimbasi.mp3',
    'sounds/kalimbases/8kalimbado1.mp3',
    'sounds/kalimbases/9kalimbare1.mp3',
    'sounds/kalimbases/10kalimbami1.mp3',
    'sounds/kalimbases/11kalimbafa1.mp3',
    'sounds/kalimbases/12kalimbasol1.mp3',
    'sounds/kalimbases/13kalimbala1.mp3',
    'sounds/kalimbases/14kalimbasi1.mp3',
    'sounds/kalimbases/15kalimbado2.mp3',
    'sounds/kalimbases/16kalimbare2.mp3',
    'sounds/kalimbases/17kalimbami2.mp3'
  ];

  @override
  void initState() {
    super.initState();
    // Ekranı yalnızca yatay moda kilitle
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // Yönlendirmeyi varsayılan ayarına döndür
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tuş uzunluklarını belirle (ortada en uzun tuş olacak şekilde)
    List<int> keyHeights = [
      130,
      145,
      160,
      175,
      190,
      205,
      220,
      235,
      250,
      235,
      220,
      205,
      190,
      175,
      160,
      145,
      130
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 500,
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
                    playSound(soundPaths[index]);
                  },
                  child: Container(
                    width: 40,
                    // Tuş genişliği sabit
                    height: keyHeights[index].toDouble(),
                    // Uzunluk listeden alınıyor
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
          Positioned(
            left: 310,
            bottom: -220,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
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
    home: KalimbaEkrani(),
    debugShowCheckedModeBanner: false,
  ));
}
