class Location {

  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double speed;
  final int time;
  final String? provider;

  Location({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.altitude,
    required this.speed,
    required this.time,
    this.provider,
  });


  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
      accuracy: json['accuracy'],
      altitude: json['altitude'],
      speed: json['speed'],
      time: json['time'],
      provider: json['provider'],
    );
  }

}