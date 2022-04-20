// ignore_for_file: file_names

class Jour {
  String id;
  String date;
  List<dynamic> values;

  Jour({
    required this.id,
    required this.date,
    required this.values,
  });

  factory Jour.fromJson(Map<String, dynamic> json) {
    return Jour(
      id: json['id'],
      date: json['date'],
      values: json['values'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'values': values,
      };
}

class Values {
  String id;
  String text;
  String value;

  Values({
    required this.id,
    required this.text,
    required this.value,
  });

  factory Values.fromJson(Map<String, dynamic> json) {
    return Values(
      id: json['id'],
      text: json['text'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'value': value,
      };
}
