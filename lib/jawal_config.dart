import 'package:jawal_flutter/events/init_result_event.dart';

class JawalConfig {

  final String apiKey;
  final String userId;
  final String? userDescription;
  final Function(InitResultEvent)? onInitResult;

  JawalConfig({
    required this.apiKey,
    required this.userId,
    this.userDescription,
    this.onInitResult,
  });

}