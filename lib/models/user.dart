class User {
  final String id;
  final String identificationKey;
  final String? description;

  User({
    required this.id,
    required this.identificationKey,
    this.description,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      identificationKey: json['sdk_identification_key'],
      description: json['description'],
    );
  }

}