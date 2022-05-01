import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tfg_frontend/endpoints/Objects/BuildingAPIValues.dart';
import 'package:tfg_frontend/endpoints/Objects/NonResidentialBuildingClassification.dart';
import 'package:tfg_frontend/endpoints/Objects/ResidentialBuildingClassification.dart';

Future<BuildingAPIValues> SaveBuildingData(
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
    String value1,
    String value2,
    String value3) async {
  var body = {
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
    return BuildingAPIValues.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store the classification');
  }
}

Future<BuildingAPIValues> UpdateBu8ildingData(
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
    String value1,
    String value2,
    String value3) async {
  var body = {
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

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return BuildingAPIValues.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store the classification');
  }
}

Future<BuildingAPIValues> DeleteBuildingData(
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
    String value1,
    String value2,
    String value3) async {
  var body = {
    'antiquity': antiquity,
    'value_type': value_type,
    'indicator': indicator,
    'building_type': building_type,
    'climatic_zone': climatic_zone,
    'value1': value1,
    'value2': value2,
    'value3': value3,
  };

  final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      body: body);

  if (response.statusCode == 204) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return BuildingAPIValues.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store the classification');
  }
}

Future<BuildingAPIValues> GetBuildingData(
    String antiquity,
    String value_type,
    String indicator,
    String building_type,
    String climatic_zone,
    String value1,
    String value2,
    String value3) async {
  var body = {
    'antiquity': antiquity,
    'value_type': value_type,
    'indicator': indicator,
    'building_type': building_type,
    'climatic_zone': climatic_zone,
    'value1': value1,
    'value2': value2,
    'value3': value3,
  };

  final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      body: body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return BuildingAPIValues.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store the classification');
  }
}
