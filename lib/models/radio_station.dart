class RadioStation {
  final String id;
  final String name;
  final String url;
  final String country;
  final int bitrate;

  RadioStation({
    required this.id,
    required this.name,
    required this.url,
    required this.country,
    required this.bitrate,
  });

  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      id: json['stationuuid'],
      name: json['name'] ?? 'Unknown',
      url: json['url'] ?? '',
      country: json['country'] ?? 'Unknown',
      bitrate: json['bitrate'] ?? 0,
    );
  }
}
