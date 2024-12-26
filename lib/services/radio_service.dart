import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/radio_station.dart';

class RadioService {
  static const String baseUrl = 'https://de1.api.radio-browser.info/json';

  /// Ülke bazlı radyo istasyonlarını getir
  static Future<List<RadioStation>> fetchStationsByCountry(String country) async {
    final url = Uri.parse('$baseUrl/stations/bycountry/$country');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((station) => RadioStation.fromJson(station)).toList();
      } else {
        throw Exception('API çağrısı başarısız oldu. Kod: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      throw Exception('API çağrısı sırasında hata oluştu.');
    }
  }

  /// Tür bazlı radyo istasyonlarını getir
  static Future<List<RadioStation>> fetchStationsByTag(String tag) async {
    final url = Uri.parse('$baseUrl/stations/bytag/$tag');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((station) => RadioStation.fromJson(station)).toList();
      } else {
        throw Exception('API çağrısı başarısız oldu. Kod: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      throw Exception('API çağrısı sırasında hata oluştu.');
    }
  }
}
