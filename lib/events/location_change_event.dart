import 'package:jawal_flutter/events/event.dart';
import 'package:jawal_flutter/models/location.dart';

class LocationChangeEvent extends Event {

  final Location location;

  LocationChangeEvent({
    required String error,
    required bool isSuccessful,
    required this.location,
  }) : super(
    error: error,
    isSuccessful: isSuccessful,
  );

  factory LocationChangeEvent.fromJson(Map<String, dynamic> json) {
    return LocationChangeEvent(
      error: json['error'],
      isSuccessful: json['isSuccessful'],
      location: Location.fromJson(json['location']),
    );
  }
}