import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tfg_frontend/endpoints/Objects/CalculationData.dart';

Future<String> createBuildingData(
    String object,
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
    String zone,
    String classification,
    String value1,
    String value2,
    String value3) async {
  var body = {
    'object': object,
    'antiquity': antiquity,
    'value_type': value_type,
    'indicator': indicator,
    'building_type': building_type,
    'climatic_zone': climatic_zone,
    'value1': value1,
    'value2': value2,
    'value3': value3,
  };

  String value1_aux = value1;
  String value2_aux = value2;
  String value3_aux = value3;

  if (value1 == '') value1_aux = '0.0';
  if (value2 == '') value2_aux = '0.0';
  if (value3 == '') value3_aux = '0.0';

  var map = Map<String, String>();

  if (object == 'Edifici') {
    map["object"] = object;
    map["antiquity"] = antiquity;
    map["value_type"] = value_type;
    map["indicator"] = indicator;
    map["object_type"] = building_type;
    map["climatic_zone"] = climatic_zone;
    map["value1"] = value1_aux;
    map["value2"] = value2_aux;
    map["value3"] = value3_aux;
    if (value_type == 'Màxim') {
      map["classification"] = classification;
    }
    if (zone != 'Escull la zona') {
      map["zone"] = zone;
    }
  } else if (object == 'Sistema software') {
    map["object"] = object;
    map["value_type"] = value_type;
    map["object_type"] = building_type;
    map["value1"] = value1_aux;
    map["value2"] = value2_aux;
    map["value3"] = value3_aux;
  }

  String jsonmap = jsonEncode(map);

  print(jsonmap);

  final response = await http.post(
      Uri.parse('https://pablogamiz.pythonanywhere.com/calculationData/'),
      body: jsonmap,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      });

  if (response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha introduït la informació de forma correcta';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return 'No s\'ha pogut crear la informació';
  }
}

Future<String> updateBuildingData(
    String object,
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
    String zone,
    String classification,
    String value1,
    String value2,
    String value3) async {
  var body = {
    'object': object,
    'antiquity': antiquity,
    'value_type': value_type,
    'indicator': indicator,
    'building_type': building_type,
    'climatic_zone': climatic_zone,
    'value1': value1,
    'value2': value2,
    'value3': value3,
  };

  String value1_aux = value1;
  String value2_aux = value2;
  String value3_aux = value3;

  if (value1 == '') value1_aux = '0.0';
  if (value2 == '') value2_aux = '0.0';
  if (value3 == '') value3_aux = '0.0';

  String url = '';

  var map = Map<String, String>();

  if (object == 'Edifici') {
    map["object"] = object;
    map["antiquity"] = antiquity;
    map["value_type"] = value_type;
    map["indicator"] = indicator;
    map["object_type"] = building_type;
    map["climatic_zone"] = climatic_zone;
    map["value1"] = value1_aux;
    map["value2"] = value2_aux;
    map["value3"] = value3_aux;
    if (value_type == 'Màxim') {
      url = 'https://pablogamiz.pythonanywhere.com/buildingMaximumData/';
    } else {
      url = 'https://pablogamiz.pythonanywhere.com/buildingCalculationData/';
    }
    url = url +
        object +
        '/' +
        antiquity +
        '/' +
        value_type +
        '/' +
        indicator +
        '/' +
        building_type +
        '/' +
        climatic_zone +
        '/';
    if (zone != 'Escull la zona') {
      map["zone"] = zone;
      url = url + zone + '/';
    }
    if (value_type == 'Màxim') {
      url = url + classification + '/';
      map["classification"] = classification;
    }
  } else if (object == 'Sistema software') {
    map["object"] = object;
    map["value_type"] = value_type;
    map["object_type"] = building_type;
    map["value1"] = value1_aux;
    map["value2"] = value2_aux;
    map["value3"] = value3_aux;

    url = 'https://pablogamiz.pythonanywhere.com/softwareCalculationData/' +
        object +
        '/' +
        building_type +
        '/' +
        value_type +
        '/';
  }

  String jsonmap = jsonEncode(map);
  print(url);
  final response = await http.put(Uri.parse(url), body: jsonmap, headers: {
    "Accept": "application/json",
    "content-type": "application/json",
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha actualitzat la informació de forma correcta';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return 'No s\'ha pogut actualitzar la informació';
  }
}

Future<String> deleteBuildingData(
    String object,
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
    String zone,
    String classification) async {
  String url = '';
  if (value_type == 'Màxim') {
    url = 'https://pablogamiz.pythonanywhere.com/buildingMaximumData/';
  } else {
    url = 'https://pablogamiz.pythonanywhere.com/buildingCalculationData/';
  }
  url = url +
      object +
      '/' +
      antiquity +
      '/' +
      value_type +
      '/' +
      indicator +
      '/' +
      building_type +
      '/' +
      climatic_zone +
      '/';
  if (zone != 'Escull la zona') {
    url = url + zone + '/';
  }
  if (value_type == 'Màxim') {
    url = url + classification + '/';
  }
  print(url);
  final response = await http.delete(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json",
  });
  if (response.statusCode == 204) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha esborrat la informació de forma correcta';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return 'No s\'ha pogut esborrar la informació';
  }
}

Future<String> deleteSoftwareData(
    String object, String value_type, String software_type) async {
  String url =
      'https://pablogamiz.pythonanywhere.com/softwareCalculationData/' +
          object +
          '/' +
          software_type +
          '/' +
          value_type +
          '/';
  final response = await http.delete(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json",
  });

  if (response.statusCode == 204) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha esborrat la informació de forma correcta';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return 'No s\'ha pogut esborrar la informació';
  }
}

Future<CalculationData> getBuildingData(
    String object,
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
    String zone,
    BuildContext context) async {
  late String url;
  if (object == 'Edifici') {
    url = 'https://pablogamiz.pythonanywhere.com/buildingCalculationData/' +
        object +
        '/' +
        antiquity +
        '/' +
        value_type +
        '/' +
        indicator +
        '/' +
        building_type +
        '/' +
        climatic_zone +
        '/';
    if (zone != '') {
      url = url + zone + '/';
    }
  } else if (object == 'Sistema software') {
    url = 'https://pablogamiz.pythonanywhere.com/softwareCalculationData/' +
        object +
        '/' +
        building_type +
        '/' +
        value_type +
        '/';
  }
  print(url);
  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json",
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CalculationData.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
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
    throw Exception('Failed to get the data');
  }
}

Future<List<CalculationData>> getCPUs() async {
  String url = 'https://pablogamiz.pythonanywhere.com/cpus/CPU/';
  http.Client client = http.Client();
  final response = await client.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<CalculationData> l = [];
    for (Map<String, dynamic> m in jsonResponse) {
      l.add(CalculationData.fromJson(m));
    }
    return l;
  } else {
    throw Exception('Failed to get the data');
  }
}

Future<CalculationData> getMaximumClass(
    String object,
    String antiquity,
    String value_type,
    String indicator,
    String type,
    String climatic_zone,
    String zone,
    String classification) async {
  String url = 'https://pablogamiz.pythonanywhere.com/buildingMaximumData/' +
      object +
      '/' +
      antiquity +
      '/' +
      value_type +
      '/' +
      indicator +
      '/' +
      type +
      '/' +
      climatic_zone +
      '/' +
      zone +
      '/' +
      classification +
      '/';
  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json",
  });
  if (response.statusCode == 200) {
    return CalculationData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to get the data');
  }
}

Future<List<CalculationData>> getGPUs() async {
  String url = 'https://pablogamiz.pythonanywhere.com/cpus/GPU/';
  http.Client client = http.Client();
  final response = await client.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonResponse = json.decode(response.body);
    final List<CalculationData> l = [];
    for (Map<String, dynamic> m in jsonResponse) {
      l.add(CalculationData.fromJson(m));
    }
    return l;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get the data');
  }
}
