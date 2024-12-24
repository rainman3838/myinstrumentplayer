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
  Widget build(BuildContext context) {


    final player = AudioPlayer();

    // Beyaz tuşlara atanacak ses dosyaları
    final List<String> whiteKeySounds = [
      'sounds/kanunses/1kanunsol.mp3',
      'sounds/kanunses/2kanunla.mp3',
      'sounds/kanunses/3kanunsi.mp3',
      'sounds/kanunses/4kanundo.mp3',
      'sounds/kanunses/1kanunsol.mp3',
      'sounds/kanunses/1kanunsol.mp3',
      'sounds/kanunses/1kanunsol.mp3',
      'sounds/kanunses/1kanunsol.mp3',
      'sounds/kanunses/1kanunsol.mp3',
      'sounds/drumses/j.wav',
      'sounds/drumses/k.wav',
      'sounds/drumses/l.wav',
    ];

    // Siyah tuşlara atanacak ses dosyaları
    final List<String> blackKeySounds = [
      'assets/do_sharp.wav',
      'assets/re_sharp.wav',
      'assets/fa_sharp.wav',
      'assets/sol_sharp.wav',
      'assets/la_sharp.wav',
      'assets/do_sharp2.wav',
      'assets/re_sharp2.wav',
      'assets/fa_sharp2.wav',
      'assets/sol_sharp2.wav',
      'assets/la_sharp2.wav',
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
                    onTap: () async {
                      await player.play(AssetSource(whiteKeySounds[index]));
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
                        onTap: () async {
                          await player.play(AssetSource(blackKeySounds[index]));
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
