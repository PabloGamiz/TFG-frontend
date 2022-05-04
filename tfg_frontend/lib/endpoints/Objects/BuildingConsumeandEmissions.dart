import 'dart:ffi';

class BuildingConsumeandEmissions {
  final int building_type;
  final String climatic_zone;
  final double heating;
  final double refrigeration;
  final double acs;

  const BuildingConsumeandEmissions({
    required this.building_type,
    required this.climatic_zone,
    required this.heating,
    required this.refrigeration,
    required this.acs,
  });

  factory BuildingConsumeandEmissions.fromJson(Map<String, dynamic> json) {
    return BuildingConsumeandEmissions(
      building_type: json['building_type'],
      climatic_zone: json['climatic_zone'],
      heating: json['heating'],
      refrigeration: json['refrigeration'],
      acs: json['ACS'],
    );
  }
}
