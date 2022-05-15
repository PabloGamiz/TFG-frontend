import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Objects/User.dart';

Future<String> createUser(
    String email, String password, String name, String surname) async {
  var map = Map<String, String>();

  map['email'] = email;
  map['name'] = name;
  map['surname'] = surname;
  map['password'] = password;

  String jsonmap = jsonEncode(map);

  final response = await http.post(
      Uri.parse('https://pablogamiz.pythonanywhere.com/user'),
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

Future<String> modifyUser(
    String email, String password, String name, String surname) async {
  var map = Map<String, String>();

  map['email'] = email;
  map['name'] = name;
  map['surname'] = surname;
  map['password'] = password;

  String url = 'https://pablogamiz.pythonanywhere.com/user/' + email;

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

Future<String> deleteUser(
    String email, String password, String name, String surname) async {
  String url = 'https://pablogamiz.pythonanywhere.com/user/' + email;

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

Future<User> getUser(String email) async {
  String url = 'https://pablogamiz.pythonanywhere.com/user/' + email;

  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  if (response.statusCode == '200') {
    return User.fromJson(jsonDecode(response.body));
  } else {
    return User(
      admin: false,
      email: '',
      name: '',
      password: '',
      surname: '',
    );
  }
}
