import 'dart:ffi';

class BuildingDemand {
  final int building_type;
  final String climatic_zone;
  final double heating;
  final double refrigeration;

  const BuildingDemand({
    required this.building_type,
    required this.climatic_zone,
    required this.heating,
    required this.refrigeration,
  });

  factory BuildingDemand.fromJson(Map<String, dynamic> json) {
    return BuildingDemand(
      building_type: json['building_type'],
      climatic_zone: json['climatic_zone'],
      heating: json['heating'],
      refrigeration: json['refrigeration'],
    );
  }
}
