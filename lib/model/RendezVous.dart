// ignore_for_file: file_names

class RendezVous {
  String text;
  String date;
  String hour;
  String sousType;
  String id;

  RendezVous({
    required this.text,
    required this.date,
    required this.hour,
    required this.id,
    required this.sousType,
  });

  factory RendezVous.fromJson(Map<String, dynamic> json) {
    return RendezVous(
      text: json['text'],
      date: json['date'],
      hour: json['hour'],
      id: json['id'],
      sousType: json['sousType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'date': date,
        'hour': hour,
        'id': id,
        'sousType': sousType,
      };
}
