import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Objects/Folder.dart';

Future<String> createFolder(
    String name, String description, String email) async {
  var map = Map<String, String>();

  map['name'] = name;
  map['description'] = description;
  map['User'] = email;

  String jsonmap = jsonEncode(map);

  final response = await http.post(
      Uri.parse('https://pablogamiz.pythonanywhere.com/folder'),
      body: jsonmap,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  if (response.statusCode == '201') {
    return 'S\'ha creat l\'usuari correctament';
  } else {
    return 'No s\'ha pogut crear l\'usuari';
  }
}

Future<String> modifyFolder(
    int id, String name, String description, String email) async {
  var map = Map<String, String>();

  map['name'] = name;
  map['description'] = description;
  map['User'] = email;

  String url = 'https://pablogamiz.pythonanywhere.com/folder/' + id.toString();

  String jsonmap = jsonEncode(map);

  final response = await http.put(Uri.parse(url), body: jsonmap, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  if (response.statusCode == '200') {
    return 'S\'ha modificat l\'usuari correctament';
  } else {
    return 'No s\'ha pogut modificar l\'usuari';
  }
}

Future<String> deleteFolder(int id) async {
  String url = 'https://pablogamiz.pythonanywhere.com/folder/' + id.toString();

  final response = await http.delete(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  if (response.statusCode == '204') {
    return 'S\'ha esborrat l\'usuari correctament';
  } else {
    return 'No s\'ha pogut esborrat l\'usuari';
  }
}

Future<Folder> getFolder(int id) async {
  String url = 'https://pablogamiz.pythonanywhere.com/folder/' + id.toString();

  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  if (response.statusCode == '200') {
    return Folder.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('No s\'ha pogut obtenir l\'usuari');
  }
}

Future<List<Folder>> getUserFolders(String email) async {
  String url =
      'https://pablogamiz.pythonanywhere.com/user/' + email + '/folder';

  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  if (response.statusCode == '200') {
    return foldersList(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('No s\'ha pogut obtenir les carpetes');
  }
}
