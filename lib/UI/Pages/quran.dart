class Quran {
  final String id, name, count, juz, place, type, index;

  Quran(
      {this.id,
      this.name,
      this.count,
      this.juz,
      this.place,
      this.type,
      this.index});

  factory Quran.fromJson(Map<String, dynamic> json) {
    return Quran(
      id: json['id'],
      name: json['name'],
      count: json['count'].toString(),
      juz: json['juz'].toString(),
      place: json['place'],
      type: json['type'],
      index: json['index'].toString(),
    );
  }
}
