import 'package:jawal_flutter/events/event.dart';
import 'package:jawal_flutter/models/user.dart';

class InitResultEvent extends Event {
  final User? user;

  InitResultEvent({
    required bool isSuccessful,
    required String? error,
    this.user,
  }) : super(
    isSuccessful: isSuccessful,
    error: error,
  );

  factory InitResultEvent.fromJson(Map<String, dynamic> json) {
    return InitResultEvent(
      error: json['error'],
      isSuccessful: json['isSuccessful'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}