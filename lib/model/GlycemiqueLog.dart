// ignore_for_file: file_names

class GlycemiqueLog {
  int uid;
  String startAt;
  String endAt;
  bool status;
  String dateS;

  GlycemiqueLog({
    required this.uid,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.dateS,
  });

  factory GlycemiqueLog.fromJson(Map<String, dynamic> json) {
    return GlycemiqueLog(
      uid: json['uid'],
      startAt: json['startAt'],
      endAt: json['endAt'],
      status: json['status'],
      dateS: json['dateS'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'startAt': startAt,
        'endAt': endAt,
        'status': status,
        'dateS': dateS,
      };
}
