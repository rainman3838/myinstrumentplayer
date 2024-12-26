import 'package:flutter/material.dart';
import '../models/radio_station.dart';
import '../services/favorites_service.dart';

class RadioListTile extends StatefulWidget {
  final RadioStation station;

  const RadioListTile({Key? key, required this.station}) : super(key: key);

  @override
  _RadioListTileState createState() => _RadioListTileState();
}

class _RadioListTileState extends State<RadioListTile> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavorite();
  }

  void checkFavorite() async {
    final favorite = await FavoritesService.isFavorite(widget.station.id);
    setState(() {
      isFavorite = favorite;
    });
  }

  void toggleFavorite() async {
    if (isFavorite) {
      await FavoritesService.removeFavorite(widget.station.id);
    } else {
      await FavoritesService.addFavorite(widget.station.id);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.station.name),
      subtitle: Text('${widget.station.country} - ${widget.station.bitrate} kbps'),
      trailing: IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        onPressed: toggleFavorite,
      ),
    );
  }
}
