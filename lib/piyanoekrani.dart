import 'package:audioplayers/audioplayers.dart';
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




    // Beyaz tuşlara atanacak ses dosyaları
    final List<String> whiteKeySounds = [
      'sounds/piyanoses/2piyano.mp3',
      'sounds/piyanoses/4piyano.mp3',
      'sounds/piyanoses/6piyano.mp3',
      'sounds/piyanoses/7piyano.mp3',
      'sounds/piyanoses/9piyano.mp3',
      'sounds/piyanoses/11piyano.mp3',
      'sounds/piyanoses/13piyano.mp3',
      'sounds/piyanoses/14piyano.mp3',
      'sounds/piyanoses/16piyano.mp3',
      'sounds/piyanoses/18piyano.mp3',
      'sounds/piyanoses/19piyano.mp3',
      'sounds/piyanoses/21piyano.mp3',
      'sounds/piyanoses/23piyano.mp3',
      'sounds/piyanoses/25piyano.mp3',
    ];

    // Siyah tuşlara atanacak ses dosyaları
    final List<String> blackKeySounds = [
      'sounds/piyanoses/3piyano.mp3',
      'sounds/piyanoses/5piyano.mp3',
      'sounds/piyanoses/8piyano.mp3',
      'sounds/piyanoses/10piyano.mp3',
      'sounds/piyanoses/12piyano.mp3',
      'sounds/piyanoses/15piyano.mp3',
      'sounds/piyanoses/17piyano.mp3',
      'sounds/piyanoses/20piyano.mp3',
      'sounds/piyanoses/22piyano.mp3',
      'sounds/piyanoses/24piyano.mp3',


    ];

    // Siyah tuşların beyaz tuşlara göre konumu (true = siyah tuş var)
    final List<bool> isSharpKey = [
      true,
      true,
      false,
      true,
      true,
      true,
      false,
      true,
      true,
      false,
      true,
      true,
      true,
      false
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
            children: List.generate(14, (index) {
              final hasSharp = isSharpKey[index];

              return Stack(
                children: [
                  // Beyaz tuş
                  GestureDetector(
                    onTap: (){
                      playSound(whiteKeySounds[index]);
                    },
                    child: Container(
                      width: 60,
                      height: 270,
                      color: Colors.white,
                      margin: const EdgeInsets.all(0.5),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),

                  // Siyah tuş (Eğer konum uygunsa)
                  if (hasSharp && index <= 12)
                    Positioned(
                      left: 30,
                      top: 0,
                      child: GestureDetector(
                        onTap: (){
                          playSound(blackKeySounds[index]);
                        },
                        child: Container(
                          width: 50,
                          height: 160,
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
