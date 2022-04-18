// ignore_for_file: file_names

class WaterReminder {
  bool status;
  double dailyQte;
  bool notification;
  int uid;
  String date;
  bool daily;
  bool isToday;
  String intake;

  WaterReminder({
    required this.status,
    required this.dailyQte,
    required this.notification,
    required this.uid,
    required this.date,
    required this.daily,
    required this.isToday,
    required this.intake,
  });

  factory WaterReminder.fromJson(Map<String, dynamic> json) {
    return WaterReminder(
      status: json['status'],
      dailyQte: json['dailyQte'],
      notification: json['notification'],
      uid: json['uid'],
      date: json['date'],
      daily: json['daily'],
      isToday: json['isToday'],
      intake: json['intake'],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'dailyQte': dailyQte,
        'notification': notification,
        'uid': uid,
        'date': date,
        'daily': daily,
        'isToday': isToday,
        'intake': intake,
      };
}
