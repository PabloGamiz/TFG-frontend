import 'dart:ffi';

class BuildingDemand {
  final int building_type;
  final String climatic_zone;
  final Float dispersion;

  const BuildingDemand({
    required this.building_type,
    required this.climatic_zone,
    required this.dispersion,
  });

  factory BuildingDemand.fromJson(Map<String, dynamic> json) {
    return BuildingDemand(
      building_type: json['building_type'],
      climatic_zone: json['climatic_zone'],
      dispersion: json['dispersion'],
    );
  }
}
