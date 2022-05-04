import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tfg_frontend/endpoints/Objects/CalculationData.dart';

Future<String> createBuildingData(
    String object,
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
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

  var map = Map<String, String>();

  map["object"] = object;
  map["antiquity"] = antiquity;
  map["value_type"] = value_type;
  map["indicator"] = indicator;
  map["object_type"] = building_type;
  map["climatic_zone"] = climatic_zone;
  map["value1"] = value1;
  map["value2"] = value2;
  map["value3"] = value3;

  String jsonmap = jsonEncode(map);

  print(jsonmap);

  print('antes de llamada');

  final response = await http.post(
      Uri.parse('https://pablogamiz.pythonanywhere.com/calculationData/'),
      body: jsonmap,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

  print(response.statusCode);
  if (response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha introduït la informació per a l\'edifici de forma correcta';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return 'No s\'ha pogut crear la informació per a l\'edifici';
  }
}

Future<String> updateBuildingData(
    String object,
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
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

  String url =
      'https://pablogamiz.pythonanywhere.com/buildingCalculationData/' +
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

  var map = Map<String, String>();

  map["object"] = object;
  map["antiquity"] = antiquity;
  map["value_type"] = value_type;
  map["indicator"] = indicator;
  map["object_type"] = building_type;
  map["climatic_zone"] = climatic_zone;
  map["value1"] = value1;
  map["value2"] = value2;
  map["value3"] = value3;

  String jsonmap = jsonEncode(map);

  final response = await http.put(Uri.parse(url), body: jsonmap, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  if (response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha actualitzat la informació per a l\'edifici de forma correcta';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return 'No s\'ha pogut actualitzar la informació per a l\'edifici';
  }
}

Future<String> deleteBuildingData(
    String object,
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone) async {
  String url =
      'https://pablogamiz.pythonanywhere.com/buildingCalculationData/' +
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
  final response = await http.delete(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  if (response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha esborrat la informació per a l\'edifici de forma correcta';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return 'No s\'ha pogut esborrar la informació per a l\'edifici';
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
    "content-type": "application/json"
  });

  if (response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return 'S\'ha esborrat la informació per a l\'edifici de forma correcta';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return 'No s\'ha pogut esborrar la informació per a l\'edifici';
  }
}

Future<CalculationData> getBuildingData(
    String object,
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
    String value1,
    String value2,
    String value3) async {
  String url =
      'https://pablogamiz.pythonanywhere.com/buildingCalculationData/' +
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
  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  if (response.statusCode == 20) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CalculationData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to get the data');
  }
}
