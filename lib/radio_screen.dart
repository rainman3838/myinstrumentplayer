import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'services/radio_service.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  List<dynamic> _stations = [];
  List<String> _favoriteStations = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _showFavorites = false;

  @override
  void initState() {
    super.initState();
    fetchStations();
    loadFavorites();
    initializeNotifications();
  }

  Future<void> fetchStations() async {
    try {
      final stations = await RadioService.fetchStationsByCountry('Türkiye');
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

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteStations = prefs.getStringList('favoriteStations') ?? [];
    });
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String stationName) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'radio_channel',
      'Radyo Bildirimleri',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );
    await _notificationsPlugin.show(
      0,
      'Radyo Çalıyor',
      'Şu an $stationName çalıyor.',
      platformDetails,
    );
  }

  Future<void> toggleFavorite(String stationName) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favoriteStations.contains(stationName)) {
        _favoriteStations.remove(stationName);
      } else {
        _favoriteStations.add(stationName);
      }
      prefs.setStringList('favoriteStations', _favoriteStations);
    });
  }

  void playStation(String url, String stationName) async {
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
      await showNotification(stationName);
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
    final displayedStations = _showFavorites
        ? _stations.where((s) => _favoriteStations.contains(s.name)).toList()
        : _stations;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Geri tuşu rengini beyaz yapar
        ),
        title: const Text(
          'Radyo Dinle',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                _showFavorites = !_showFavorites;
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade700,
              Colors.deepPurple.shade400,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (displayedStations.isNotEmpty)
              SizedBox(
                height: 250,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 80,
                  diameterRatio: 2,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      if (index < 0 || index >= displayedStations.length) {
                        return null;
                      }
                      final station = displayedStations[index];
                      final isFavorite = _favoriteStations.contains(station.name);
                      return Card(
                        color: Colors.deepPurple.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            station.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.white,
                            ),
                            onPressed: () => toggleFavorite(station.name),
                          ),
                        ),
                      );
                    },
                    childCount: displayedStations.length,
                  ),
                ),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 40),
                backgroundColor: _isPlaying
                    ? Colors.redAccent
                    : Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: _isPlaying
                  ? stopStation
                  : () => playStation(
                displayedStations[_currentIndex].url,
                displayedStations[_currentIndex].name,
              ),
              child: Text(
                _isPlaying ? 'Radyo Durdur' : 'Radyo Başlat',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
