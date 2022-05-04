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

  const CalculationData({
    required this.object,
    required this.antiquity,
    required this.value_type,
    required this.indicator,
    required this.building_type,
    required this.climatic_zone,
    required this.value1,
    required this.value2,
    required this.value3,
  });

  factory CalculationData.fromJson(Map<String, dynamic> json) {
    return CalculationData(
      object: json['object'],
      antiquity: json['antiquity'],
      value_type: json['value_type'],
      indicator: json['indicator'],
      building_type: json['building_type'],
      climatic_zone: json['climatic_zone'],
      value1: json['value1'],
      value2: json['value2'],
      value3: json['value3'],
    );
  }
}
