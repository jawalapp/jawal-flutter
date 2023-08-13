abstract class Event {

  final bool isSuccessful;
  final String? error;

  Event({
    required this.isSuccessful,
    required this.error,
  });
}