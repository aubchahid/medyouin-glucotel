// ignore_for_file: file_names

class Aliment {
  String id;
  String aliment;
  String calories;
  String glucides;
  String lipides;
  String proteines;
  String indexGlycemique;
  String image;

  Aliment({
    required this.aliment,
    required this.calories,
    required this.image,
    required this.id,
    required this.glucides,
    required this.lipides,
    required this.proteines,
    required this.indexGlycemique,
  });

  factory Aliment.fromJson(Map<String, dynamic> json) {
    return Aliment(
      aliment: json['aliment'],
      calories: json['calories'],
      image: json['image'],
      id: json['id'],
      glucides: json['glucides'],
      lipides: json['lipides'],
      proteines: json['proteines'],
      indexGlycemique: json['indexGlycemique'],
    );
  }

  Map<String, dynamic> toJson() => {
        'aliment': aliment,
        'calories': calories,
        'image': image,
        'id': id,
        'lipides': lipides,
        'proteines': proteines,
        'indexGlycemique': indexGlycemique,
      };
}
