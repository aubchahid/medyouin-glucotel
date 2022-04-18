// ignore_for_file: file_names

class User {
  String id;
  String fullname;
  String email;
  String phoneNo;
  String sexe;
  String birthdate;
  String typeDiabet;
  String weight;
  String size;
  String city;
  String glycPreMealT1;
  String glycPreMealT2;
  String glycPreMealT3;
  String glycPostMealT1;
  String glycPostMealT2;
  String glycPostMealT3;
  String hba1c;
  String stepsPerDay;
  String photoUrl;
  bool status;
  bool isGoogle;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phoneNo,
    this.sexe = "Femme",
    this.birthdate = "01-01-2022",
    this.typeDiabet = "Type 1",
    this.weight = "70",
    this.size = "175",
    this.city = "Rabat",
    this.glycPreMealT1 = "0.68",
    this.glycPreMealT2 = "1.80",
    this.glycPreMealT3 = "2.50",
    this.glycPostMealT1 = "0.68",
    this.glycPostMealT2 = "1.80",
    this.glycPostMealT3 = "2.50",
    this.hba1c = "",
    this.stepsPerDay = "10000",
    required this.photoUrl,
    required this.status,
    required this.isGoogle,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      sexe: json['sexe'],
      birthdate: json['birthdate'],
      typeDiabet: json['typeDiabet'],
      weight: json['weight'],
      size: json['size'],
      city: json['city'],
      glycPreMealT1: json['glycPreMealT1'],
      glycPreMealT2: json['glycPreMealT2'],
      glycPreMealT3: json['glycPreMealT3'],
      glycPostMealT1: json['glycPostMealT1'],
      glycPostMealT2: json['glycPostMealT2'],
      glycPostMealT3: json['glycPostMealT3'],
      hba1c: json['hba1c'],
      stepsPerDay: json['stepsPerDay'],
      photoUrl: json['photoUrl'],
      status: json['status'],
      isGoogle: json['isGoogle'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'phoneNo': phoneNo,
        'sexe': sexe,
        'birthdate': birthdate,
        'typeDiabet': typeDiabet,
        'weight': weight,
        'size': size,
        'city': city,
        'glycPreMealT1': glycPreMealT1,
        'glycPreMealT2': glycPreMealT2,
        'glycPreMealT3': glycPreMealT3,
        'glycPostMealT1': glycPostMealT1,
        'glycPostMealT2': glycPostMealT2,
        'glycPostMealT3': glycPostMealT3,
        'hba1c': hba1c,
        'stepsPerDay': stepsPerDay,
        'photoUrl': photoUrl,
        'status': status,
        'isGoogle': isGoogle
      };
}
