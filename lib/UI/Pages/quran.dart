class Quran {
  final String id,
      name,
      count,
      juz,
      place,
      type,
      index,
      highlight,
      subject,
      prostration,
      order;
//  final List<String> verse;

  Quran(
      {this.id,
      this.name,
      this.count,
      this.juz,
      this.place,
      this.type,
      this.index,
      this.highlight,
      this.order,
      this.prostration,
      this.subject});

  factory Quran.fromJson(Map<String, dynamic> json) {
    return Quran(
        id: json['id'],
        name: json['name'],
        count: json['count'].toString(),
        juz: json['juz'].toString(),
        place: json['place'],
        type: json['type'],
        index: json['index'].toString(),
        highlight: json['highlight'].toString(),
        order: json['order'].toString(),
        prostration: json['Prostration'],
        subject: json['subject']
//      verse: json['verses']
        );
  }
}
