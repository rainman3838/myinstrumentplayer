import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'services/radio_service.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<dynamic> _stations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStations();
  }

  Future<void> fetchStations() async {
    try {
      final stations = await RadioService.fetchStationsByCountry('Germany');
      setState(() {
        _stations = stations;
        _isLoading = false;
      });
    } catch (e) {
      print('Hata: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void playStation(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
    } catch (e) {
      print('Radyo oynatma hatası: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radyo Dinle'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _stations.length,
        itemBuilder: (context, index) {
          final station = _stations[index]; // RadioStation nesnesi
          return ListTile(
            title: Text(station.name), // Doğrudan name özelliğine erişim
            subtitle: Text('${station.country} - ${station.bitrate} kbps'), // country ve bitrate
            onTap: () {
              playStation(station.url); // URL'yi çalma
            },
          );
        },
      )

    );
  }
}
