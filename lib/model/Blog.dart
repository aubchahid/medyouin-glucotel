// ignore_for_file: file_names

class Blog {
  String title;
  String contenu;
  String image;
  String id;
  String createdAt;

  Blog({
    required this.title,
    required this.contenu,
    required this.image,
    required this.id,
    required this.createdAt,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      title: json['title'],
      contenu: json['contenu'],
      image: json['image'],
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'contenu': contenu,
        'image': image,
        'id': id,
        'createdAt': createdAt,
      };
}
