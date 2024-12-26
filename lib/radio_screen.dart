import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'services/radio_service.dart';
import 'package:flutter/cupertino.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<dynamic> _stations = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  bool _isPlaying = false;

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
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print('Radyo oynatma hatası: $e');
    }
  }

  void stopStation() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      print('Radyo durdurma hatası: $e');
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
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_stations.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                _stations[_currentIndex].name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          CupertinoPicker(
            itemExtent: 50,
            onSelectedItemChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: _stations
                .map((station) => Center(
              child: Text(
                station.name,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ))
                .toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isPlaying
                ? stopStation
                : () => playStation(_stations[_currentIndex].url),
            child: Text(_isPlaying ? 'Stop Radio' : 'Start Radio'),
          ),
        ],
      ),
    );
  }
}
