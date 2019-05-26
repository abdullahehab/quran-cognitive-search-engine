class Speech {
  final String alternatives;

  Speech({this.alternatives});

  factory Speech.fromJson(Map<String, dynamic> json) {
    return Speech(alternatives: json['alternatives']);
  }
}
