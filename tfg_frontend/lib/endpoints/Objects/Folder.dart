import 'dart:convert';

List<Folder> foldersList(String str) =>
    List<Folder>.from(json.decode(str).map((x) => Folder.fromJson(x)));

class Folder {
  final int id;
  final String name;
  final String description;
  final int user;

  const Folder(
      {required this.id,
      required this.name,
      required this.description,
      required this.user});

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        user: json['user']);
  }
}
