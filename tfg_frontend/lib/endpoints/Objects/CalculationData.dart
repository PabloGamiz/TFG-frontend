import 'dart:convert';
import 'dart:core';

List<CalculationData> calculationDataList(String str) =>
    List<CalculationData>.from(
        json.decode(str).map((x) => CalculationData.fromJson(x)));

List<CalculationData> listCalculationData(dynamic str) =>
    List<CalculationData>.from(
        json.decode(str).map((x) => CalculationData.fromJson(x)));

List<CalculationData> parseData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, CalculationData>>();

  /*return List<CalculationData>.from(
      parsed.map((model) => CalculationData.fromJson(model)));
  final list = parsed.cast<Map<String, CalculationData>>();*/
  return parsed
      .map<CalculationData>((json) => CalculationData.fromJson(json))
      .toList();
}

class CalculationData {
  final String object;
  final String antiquity;
  final String value_type;
  final String indicator;
  final String building_type;
  final String climatic_zone;
  final String value1;
  final String value2;
  final String value3;
  final String zone;
  final String classification;

  const CalculationData(
      {required this.object,
      required this.antiquity,
      required this.value_type,
      required this.indicator,
      required this.building_type,
      required this.climatic_zone,
      required this.value1,
      required this.value2,
      required this.value3,
      required this.zone,
      required this.classification});

  factory CalculationData.fromJson(Map<String, dynamic> json) {
    return CalculationData(
        object: json['object'] as String,
        antiquity: json['antiquity'] as String,
        value_type: json['value_type'] as String,
        indicator: json['indicator'] as String,
        building_type: json['object_type'] as String,
        climatic_zone: json['climatic_zone'] as String,
        value1: json['value1'] as String,
        value2: json['value2'] as String,
        value3: json['value3'] as String,
        zone: json['zone'],
        classification: json['classification']);
  }
}
