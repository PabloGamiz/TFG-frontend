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

  final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      body: body);

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

  final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      body: body);

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
    String climatic_zone,
    String value1,
    String value2,
    String value3) async {
  final response = await http
      .delete(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

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
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

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
