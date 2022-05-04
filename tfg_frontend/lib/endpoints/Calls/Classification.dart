import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:tfg_frontend/endpoints/Objects/NonResidentialBuildingClassification.dart';
import 'package:tfg_frontend/endpoints/Objects/ClassificationData.dart';

Future<String> createClassificationData(
    String number_metrics,
    String calification,
    String min_C1,
    String max_C1,
    String min_C2,
    String max_C2) async {
  print('dentro de classification data');

  var map = Map<String, String>();

  map["number_metrics"] = number_metrics;
  map["calification"] = calification;
  map["min_C1"] = min_C1;
  map["max_C1"] = max_C1;
  map["min_C2"] = min_C2;
  map["max_C2"] = max_C2;

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
  print('antes de llamada');
  print(jsonbody);

  final response = await http.post(
      Uri.parse('https://pablogamiz.pythonanywhere.com/classificationData/'),
      body: jsonmap,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  print(response.body);

  print('despues de llamada');
  if (response.statusCode == 201) {
    print('ha creado correctamente la clasificacion');
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'La classificació s\'ha creat correctament';
  } else {
    print(response.statusCode);
    print('no ha creado la clasificacion');
    // If the server did not return a 200 OK response,
    // then throw an exception.
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
  var body = {
    'number_metrics': number_metrics,
    'calification': calification,
    'min_C1': min_C1,
    'max_C1': max_C1,
    'min_C2': min_C2,
    'max_C2': max_C2
  };

  var map = Map<String, String>();

  map["number_metrics"] = number_metrics;
  map["calification"] = calification;
  map["min_C1"] = min_C1;
  map["max_C1"] = max_C1;
  map["min_C2"] = min_C2;
  map["max_C2"] = max_C2;

  String jsonmap = jsonEncode(map);

  String url = 'https://pablogamiz.pythonanywhere.com/classificationData/' +
      number_metrics +
      '/' +
      calification +
      '/';

  print(url);
  print(jsonmap);
  final response = await http.put(Uri.parse(url), body: jsonmap, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  print(response.statusCode);

  if (response.statusCode == 200) {
    print('actualiza correctamente');
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha actulitzat correctament la classificació';
  } else {
    print('no actualiza');
    // If the server did not return a 200 OK response,
    // then throw an exception.
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
    "content-type": "application/json"
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
    String number_metrics, String C1, String C2) async {
  String url = '';
  if (number_metrics == 2) {
    if (C2 == '') {
      url = 'https://pablogamiz.pythonanywhere.com/classificationDataC1/' +
          number_metrics +
          '/' +
          C1 +
          '/';
    } else {
      url = 'https://pablogamiz.pythonanywhere.com/classificationDataC1C2/' +
          C1 +
          '/' +
          C2 +
          '/';
    }
  } else {
    url = 'https://pablogamiz.pythonanywhere.com/classificationDataC1/' +
        number_metrics +
        '/' +
        C1 +
        '/';
  }

  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ClassificationData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store the classification');
  }
}
