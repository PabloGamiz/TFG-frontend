import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tfg_frontend/endpoints/Objects/ResidentialBuildingClassification.dart';

Future<ResidentialBuildingClassification> SaveClassificationC1C2(
    String calification,
    String min_C1,
    String max_C1,
    String min_C2,
    String max_C2) async {
  var body = {
    'calification': calification,
    'min_C1': min_C1,
    'max_C1': max_C1,
    'min_C2': min_C2,
    'max_C2': max_C2
  };

  final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      body: body);

  if (response.statusCode == 201) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ResidentialBuildingClassification.fromJson(
        jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to store the classification');
  }
}
