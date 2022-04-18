// ignore_for_file: file_names

class Glucose {
  String id;
  String value;
  String date;
  String period;
  String hour;
  String minute;
  String day;
  String month;
  String year;

  Glucose({
    required this.id,
    required this.value,
    required this.date,
    required this.period,
    required this.hour,
    required this.minute,
    required this.day,
    required this.month,
    required this.year,
  });

  factory Glucose.fromJson(Map<String, dynamic> json) {
    return Glucose(
      id: json['id'],
      value: json['value'],
      date: json['date'],
      period: json['period'],
      hour: json['hour'],
      minute: json['minute'],
      day: json['day'],
      month: json['month'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'date': date,
        'period': period,
        'hour': hour,
        'minute': minute,
        'day': day,
        'month': month,
        'year': year,
      };
}
