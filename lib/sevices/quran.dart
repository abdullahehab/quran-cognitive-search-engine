class Quran {

  final String id;
  final String name;

  Quran({ this.id, this.name});

  factory Quran.fromJson(Map<String, dynamic> json) {
    return Quran(
      id: json['id'],
      name: json['name'],
    );
  }
}