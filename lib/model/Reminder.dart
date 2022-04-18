// ignore_for_file: file_names

class Reminder {
  String text;
  String date;
  String hour;
  String qte;
  String sousType;

  String id;

  Reminder({
    required this.text,
    required this.date,
    required this.hour,
    required this.qte,
    required this.id,
    required this.sousType,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      text: json['text'],
      date: json['date'],
      hour: json['hour'],
      qte: json['qte'],
      id: json['id'],
      sousType: json['sousType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'date': date,
        'hour': hour,
        'qte': qte,
        'id': id,
        'sousType': sousType,
      };
}
