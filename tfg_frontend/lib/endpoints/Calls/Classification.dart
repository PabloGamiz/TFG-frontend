import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tfg_frontend/endpoints/Objects/ClassificationData.dart';

Future<String> createClassificationData(
    String number_metrics,
    String calification,
    String min_C1,
    String max_C1,
    String min_C2,
    String max_C2) async {
  var map = Map<String, String>();

  map["number_metrics"] = number_metrics;
  map["calification"] = calification;
  map["min_C1"] = min_C1;
  map["max_C1"] = max_C1;
  if (number_metrics != '1') {
    map["min_C2"] = min_C2;
    map["max_C2"] = max_C2;
  }

  String jsonmap = jsonEncode(map);

  var body = {
    "number_metrics": number_metrics,
    "calification": calification,
    "min_C1": min_C1,
    "max_C1": max_C1,
    "min_C2": min_C2,
    "max_C2": max_C2
  };

  final jsonbody = json.encode(body);

  final response = await http.post(
      Uri.parse('https://pablogamiz.pythonanywhere.com/classificationData/'),
      body: jsonmap,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      });

  if (response.statusCode == 201) {
    return 'La classificació s\'ha creat correctament';
  } else {
    return 'No s\'ha pogut crear la classificació';
  }
}

Future<String> updateClassificationData(
    String number_metrics,
    String calification,
    String min_C1,
    String max_C1,
    String min_C2,
    String max_C2) async {
  var map = Map<String, String>();

  map["number_metrics"] = number_metrics;
  map["calification"] = calification;
  map["min_C1"] = min_C1;
  map["max_C1"] = max_C1;
  if (number_metrics != '1') {
    map["min_C2"] = min_C2;
    map["max_C2"] = max_C2;
  }

  String jsonmap = jsonEncode(map);

  String url = 'https://pablogamiz.pythonanywhere.com/classificationData/' +
      number_metrics +
      '/' +
      calification +
      '/';

  print(url);
  final response = await http.put(Uri.parse(url), body: jsonmap, headers: {
    "Accept": "application/json",
    "content-type": "application/json",
  });

  if (response.statusCode == 200) {
    return 'S\'ha actulitzat correctament la classificació';
  } else {
    return 'No s\'ha pogut actualitzar la classificació';
  }
}

Future<String> deleteClassificationData(
    String number_metrics, String calification) async {
  String url = 'https://pablogamiz.pythonanywhere.com/classificationData/' +
      number_metrics.toString() +
      '/' +
      calification +
      '/';

  final response = await http.delete(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json",
  });

  if (response.statusCode == 204) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha esborrat la classificació';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return 'No s\'ha pogut esborrar la classificació';
  }
}

Future<ClassificationData> getClassificationData(
    String number_metrics, String C1, String C2, BuildContext context) async {
  print(C2);
  String C1_aux = C1;
  String C2_aux = C2;
  if (double.parse(C1) == double.parse(C1).toInt()) {
    C1_aux = C1_aux + '.0';
  }

  if (double.parse(C2) == double.parse(C2).toInt()) {
    C2_aux = C2_aux + '.0';
  }

  String url = '';
  if (number_metrics == '2') {
    url = 'https://pablogamiz.pythonanywhere.com/classificationDataC1C2/' +
        number_metrics +
        '/' +
        C1_aux +
        '/' +
        C2_aux +
        '/';
  } else {
    url = 'https://pablogamiz.pythonanywhere.com/classificationDataC/' +
        number_metrics +
        '/' +
        C1_aux +
        '/';
  }
  print(url);
  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json",
  });
  if (response.statusCode == 200) {
    return ClassificationData.fromJson(jsonDecode(response.body));
  } else {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Hi ha hagut un error en el càlcul',
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Continuar',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
              )
            ],
          );
        });
    throw Exception('Failed to store the classification');
  }
}
