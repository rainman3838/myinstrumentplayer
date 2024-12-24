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
    // Ekranın sadece yatay modda görüntülenmesini sağlamak
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    @override
    void dispose() {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      super.dispose();
    }

    final player = AudioPlayer();

    // Beyaz tuşlara atanacak ses dosyaları
    final List<String> whiteKeySounds = [
      'assets/do.wav',
      'assets/re.wav',
      'assets/mi.wav',
      'assets/fa.wav',
      'assets/sol.wav',
      'assets/la.wav',
      'assets/si.wav',
      'assets/do2.wav',
      'assets/re2.wav',
      'assets/mi2.wav',
      'assets/fa2.wav',
      'assets/sol2.wav',
      'assets/la2.wav',
      'assets/si2.wav',
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
