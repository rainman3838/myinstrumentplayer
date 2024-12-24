import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiRadyo extends StatefulWidget {
  @override
  _ApiRadyoState createState() => _ApiRadyoState();
}

class _ApiRadyoState extends State<ApiRadyo> {
  double frequency = 98.0; // Başlangıç frekansı
  bool isPlaying = false; // Radyo durumu
  final AudioPlayer _audioPlayer = AudioPlayer(); // Just Audio player
  String streamUrl = ''; // Yayın URL'si
  String stationId = 's307b15171'; // Radio.co istasyon ID'si
  String apiBaseUrl = 'https://public.radio.co';

  // Yayın URL'sini API'den al
  Future<void> fetchStreamUrl() async {
    final url = Uri.parse('$apiBaseUrl/stations/$stationId/status');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          streamUrl = data['relays'][0]['url'] ?? '';
        });
      } else {
        throw Exception('Failed to fetch station status');
      }
    } catch (e) {
      print('Error fetching stream URL: $e');
    }
  }

  // Radyo çalma ve durdurma
  Future<void> toggleRadio() async {
    if (isPlaying) {
      await _audioPlayer.stop();
    } else {
      if (streamUrl.isNotEmpty) {
        await _audioPlayer.setUrl(streamUrl);
        await _audioPlayer.play();
      }
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStreamUrl();
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Kaynakları serbest bırak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Player'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Frekans Gösterici
          Text(
            '${frequency.toStringAsFixed(1)} MHz',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          // Frekans Ayar Kaydırıcısı
          Slider(
            value: frequency,
            min: 88.0,
            max: 108.0,
            divisions: 200,
            label: frequency.toStringAsFixed(1),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey.shade300,
            onChanged: (value) {
              setState(() {
                frequency = value;
              });
            },
          ),
          const SizedBox(height: 20),
          // Çalma ve Durdurma Butonu
          ElevatedButton.icon(
            onPressed: toggleRadio,
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            label: Text(isPlaying ? 'Stop' : 'Play'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              backgroundColor: isPlaying ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 40),
          // Durum Bilgisi
          Text(
            isPlaying
                ? 'Playing ${frequency.toStringAsFixed(1)} MHz'
                : 'Radio is stopped',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
