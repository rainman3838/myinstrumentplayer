import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String favoritesKey = 'favorites';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favoritesKey) ?? [];
  }

  static Future<void> addFavorite(String stationId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    if (!favorites.contains(stationId)) {
      favorites.add(stationId);
      await prefs.setStringList(favoritesKey, favorites);
    }
  }

  static Future<void> removeFavorite(String stationId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(stationId);
    await prefs.setStringList(favoritesKey, favorites);
  }

  static Future<bool> isFavorite(String stationId) async {
    final favorites = await getFavorites();
    return favorites.contains(stationId);
  }
}
