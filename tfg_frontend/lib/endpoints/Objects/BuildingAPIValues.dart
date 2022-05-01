class BuildingAPIValues {
  final String antiquity;
  final String value_type;
  final String indicator;
  final String building_type;
  final String climatic_zone;
  final String value1;
  final String value2;
  final String value3;

  const BuildingAPIValues({
    required this.antiquity,
    required this.value_type,
    required this.indicator,
    required this.building_type,
    required this.climatic_zone,
    required this.value1,
    required this.value2,
    required this.value3,
  });

  factory BuildingAPIValues.fromJson(Map<String, dynamic> json) {
    return BuildingAPIValues(
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
